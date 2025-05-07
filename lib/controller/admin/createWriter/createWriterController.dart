import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class CreateWriterController extends GetxController {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  var obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void register() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("خطأ", "كلمتا المرور غير متطابقتين");
      return;
    }

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

    isLoading.value = false;

    if (response != null) {
      // في حال كانت الاستجابة ناجحة ومفكوكة
      if (response['message'] != null) {
        Get.snackbar("تم التسجيل", response['message']);
      } else if (response['errors'] != null) {
        // الأخطاء الخاصة بالـ Laravel Validation
        String errorMessage = '';
        response['errors'].forEach((key, value) {
          errorMessage += "$key: ${value[0]}\n";
        });

        Get.snackbar("خطأ في التحقق", errorMessage.trim());
      } else {
        // أي رسالة أخرى
        Get.snackbar("ملاحظة", "لم يتم استقبال رسالة واضحة من الخادم");
      }
    } else {
      // تمت معالجته بالفعل داخل ErrorHandler
      print("فشل الاتصال أو حصل استثناء أثناء التسجيل");
    }
  }
}
