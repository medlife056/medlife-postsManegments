import 'package:get/get.dart';
import 'package:MedLife/Screens/content_writer/contentWriterHomeScreen.dart';
import 'package:MedLife/Screens/coordinater/coordinater_home.dart';
import 'package:MedLife/Screens/designer/designer_home.dart';
import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:MedLife/Screens/admin/admin_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login(String email, String password) async {
    try {
      final response = await ErrorHandler.safeApiCall(() {
        return http.post(
          Uri.parse(AppLink.login),
          body: {'name': email, 'password': password},
        );
      });
      print(response['data']);

      if (response != null && response['data'] != null) {
        final token = response['data']['token'];
        final role = response['data']['role'];
        final cellId = response['data']['id'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token);
        await prefs.setInt('cellId', cellId);

        print(response);

        if (token != null) {
          if (role == 'admin') {
            Get.offAll(() => AdminHomeScreen());
          }
          if (role == 'design') {
            Get.offAll(() => DesignerHomeScreen());
          }
          if (role == 'coordinate') {
            Get.offAll(() => CoordinaterHomeScreen());
          }
          if (role == 'content_writer') {
            Get.offAll(() => ContentWriterHomeScreen());
          } else {
            // مثلاً ممكن تعرض رسالة أو تنتقل لواجهة مختلفة حسب الدور
            Get.defaultDialog(
              title: 'تم الدخول',
              middleText: 'مرحباً بك!',
              textConfirm: 'حسناً',
              confirmTextColor: Colors.white,
              onConfirm: () => Get.back(),
            );
          }

          return true;
        } else {
          Get.defaultDialog(
            title: 'خطأ',
            middleText: 'لم يتم استلام رمز المصادقة',
            textConfirm: 'موافق',
            confirmTextColor: Colors.white,
            onConfirm: () => Get.back(),
          );
        }
      } else {
        Get.defaultDialog(
          title: 'فشل الدخول',
          middleText: 'البيانات غير صحيحة أو مفقودة',
          textConfirm: 'موافق',
          confirmTextColor: Colors.white,
          onConfirm: () => Get.back(),
        );
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'استثناء',
        middleText: e.toString(),
        textConfirm: 'موافق',
        confirmTextColor: Colors.white,
        onConfirm: () => Get.back(),
      );
    }

    return false;
  }
}
