import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ErrorHandler {
  static void init() {
    // يمسك كل الأخطاء في الـ Flutter
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      _handleError(details.exception);
    };

    // يمسك الأخطاء غير المتوقعة
    runZonedGuarded(
      () {
        runApp(MyApp()); // غير هذا لتطبيقك
      },
      (error, stack) {
        _handleError(error);
      },
    );
  }

  static void _handleError(Object error) {
    String message = "حدث خطأ غير متوقع";

    if (error is SocketException) {
      message = "تحقق من اتصال الإنترنت";
    } else if (error is TimeoutException) {
      message = "انتهت مهلة الاتصال بالخادم";
    } else if (error is FormatException) {
      message = "خطأ في تنسيق البيانات";
    } else {
      message = error.toString();
    }

    Get.snackbar("خطأ", message, backgroundColor: Colors.red.shade100);
  }

  static Future<dynamic> safeApiCall(
    Future<http.Response> Function() request,
  ) async {
    try {
      final response = await request().timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final body = jsonDecode(response.body);
        final message =
            body['message'] ?? "خطأ بالخادم (${response.statusCode})";
        Get.snackbar(
          "خطأ في الطلب",
          message,
          backgroundColor: Colors.red.shade100,
        );
        return null;
      }
    } on SocketException {
      Get.snackbar("انقطاع الشبكة", "تحقق من الاتصال بالإنترنت");
    } on TimeoutException {
      Get.snackbar("مهلة منتهية", "الخادم لم يستجب في الوقت المناسب");
    } on FormatException {
      Get.snackbar("خطأ في البيانات", "البيانات المستلمة غير مفهومة");
    } catch (e) {
      Get.snackbar("حدث خطأ", e.toString());
    }
    return null;
  }
}
