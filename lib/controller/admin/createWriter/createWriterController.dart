import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateWriterController extends GetxController {
  final nameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  var obscurePassword = true.obs;

  /// للـ UI
  var successMessage = RxnString();

  var errorMessage = RxnString();

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<bool> register() async {
    if (passwordController.text != confirmPasswordController.text) {
      errorMessage.value = "كلمتا المرور غير متطابقتين";

      return false;
    }

    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('access_token');

      final response = await ErrorHandler.safeApiCall(() {
        return http.post(
          Uri.parse(AppLink.createWriter),

          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },

          body: {
            'name': nameController.text,

            'password': passwordController.text,

            'password_confirmation': confirmPasswordController.text,
          },
        );
      });

      print("CREATE WRITER => $response");

      if (response == null) {
        errorMessage.value = "فشل الاتصال بالسيرفر";

        return false;
      }

      final body = response['body'];

      /// نجاح
      if (body['message'] != null) {
        successMessage.value = body['message'];

        return true;
      }

      /// Validation Errors
      if (body['errors'] != null) {
        String errorText = '';

        body['errors'].forEach((key, value) {
          errorText += "$key : ${value[0]}\n";
        });

        errorMessage.value = errorText.trim();

        return false;
      }

      errorMessage.value = "حدث خطأ غير متوقع";

      return false;
    } catch (e) {
      errorMessage.value = e.toString();

      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
