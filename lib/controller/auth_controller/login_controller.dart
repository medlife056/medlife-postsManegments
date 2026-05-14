import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/controller/auth_controller/login_service.dart';

import 'package:MedLife/Screens/admin/admin_home.dart';
import 'package:MedLife/Screens/designer/designer_home.dart';
import 'package:MedLife/Screens/coordinater/coordinater_home.dart';
import 'package:MedLife/Screens/content_writer/contentWriterHomeScreen.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePassword = true.obs;

  final AuthService _authService = AuthService();

  final RxBool isLoading = false.obs;
  final RxnString role = RxnString();

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<bool> login() async {
    isLoading.value = true;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final result = await _authService.login(email, password);
    print("LOGIN RESULT => $result");

    isLoading.value = false;

    if (result == null) {
      return false;
    }

    role.value = result['role'];

    _navigateByRole(role.value!);

    return true;
  }

  void _navigateByRole(String role) {
    if (role == 'admin') {
      Get.offAll(() => AdminHomeScreen());
    } else if (role == 'designer') {
      Get.offAll(() => DesignerHomeScreen());
    } else if (role == 'coordinator') {
      Get.offAll(() => CoordinaterHomeScreen());
    } else if (role == 'content_writer') {
      Get.offAll(() => ContentWriterHomeScreen());
    }
  }
}
