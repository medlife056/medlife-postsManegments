import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ErrorHandler {
  ErrorHandler._();

  // ─── Global Scaffold Key ─────────────────────────────────────────────────
  // Add this key to your MaterialApp: scaffoldMessengerKey: ErrorHandler.messengerKey
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // ─── Init ────────────────────────────────────────────────────────────────

  static void init() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      debugPrint("Flutter Error: ${details.exception}");
      debugPrintStack(stackTrace: details.stack);
      handle(details.exception);
    };
  }

  // ─── Public Handle ───────────────────────────────────────────────────────

  static void handle(Object error) {
    final message = _mapErrorToMessage(error);
    debugPrint("⚠️ Handled Error => $message");
    _showSnackbar(message);
  }

  // ─── Safe API Call ───────────────────────────────────────────────────────

  static Future<Map<String, dynamic>?> safeApiCall(
    Future<http.Response> Function() request,
  ) async {
    try {
      final response = await request().timeout(const Duration(seconds: 15));

      debugPrint("📡 STATUS CODE => ${response.statusCode}");
      debugPrint("📦 RESPONSE => ${response.body}");

      // Try to decode JSON — return null body if HTML or invalid
      dynamic decodedBody;
      try {
        decodedBody = jsonDecode(response.body);
      } catch (_) {
        debugPrint("⚠️ Non-JSON response (HTML error page or empty body)");
        decodedBody = null;
      }

      // Treat 4xx / 5xx as handled errors
      if (response.statusCode >= 400) {
        final serverMessage = _extractServerMessage(decodedBody);
        _showSnackbar(
          serverMessage ?? _httpStatusMessage(response.statusCode),
        );
      }

      return {
        'statusCode': response.statusCode,
        'body': decodedBody,
      };
    } on TimeoutException {
      handle(TimeoutException('timeout'));
      return null;
    } on SocketException catch (e) {
      handle(e);
      return null;
    } on http.ClientException catch (e) {
      handle(e);
      return null;
    } catch (e) {
      handle(e);
      return null;
    }
  }

  // ─── Error → Message ─────────────────────────────────────────────────────

  static String _mapErrorToMessage(Object error) {
    if (error is SocketException) return "تحقق من اتصال الإنترنت";
    if (error is TimeoutException) return "انتهت مهلة الاتصال بالخادم";
    if (error is FormatException) return "خطأ في تنسيق البيانات";
    if (error is http.ClientException) return "فشل في الاتصال بالخادم";
    return error.toString().replaceAll("Exception: ", "");
  }

  static String? _extractServerMessage(dynamic body) {
    if (body == null || body is! Map) return null;
    final msg = body['message'] ?? body['error'] ?? body['msg'];
    if (msg == null) return null;
    return msg.toString();
  }

  static String _httpStatusMessage(int statusCode) {
    switch (statusCode) {
      case 400: return "طلب غير صحيح";
      case 401: return "غير مصرح لك، يرجى تسجيل الدخول مجدداً";
      case 403: return "ليس لديك صلاحية للوصول";
      case 404: return "المورد غير موجود";
      case 408: return "انتهت مهلة الطلب";
      case 422: return "بيانات غير صحيحة";
      case 429: return "طلبات كثيرة، حاول لاحقاً";
      case 500: return "خطأ في الخادم، حاول لاحقاً";
      case 502: return "الخادم غير متاح حالياً";
      case 503: return "الخدمة غير متاحة مؤقتاً";
      default:  return "حدث خطأ غير متوقع ($statusCode)";
    }
  }

  // ─── Snackbar via ScaffoldMessenger (no overlay issues) ──────────────────

  static void _showSnackbar(String message) {
    try {
      final messenger = messengerKey.currentState;

      if (messenger == null) {
        debugPrint("🚫 Snackbar skipped => messengerKey not attached");
        return;
      }

      messenger.hideCurrentSnackBar();

      messenger.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    } catch (e) {
      debugPrint("🚫 Snackbar Error => $e");
    }
  }
}