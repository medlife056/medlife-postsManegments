import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/controller/auth_controller/login_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePassword = true.obs;
  final AuthService _authService = AuthService();

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final success = await _authService.login(email, password);
    if (success) {
      Get.defaultDialog(
        title: 'Success',
        middleText: 'Login Successfully',
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () => Get.back(),
        backgroundColor: Colors.white,
        titleStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      );
    } else {
      Get.defaultDialog(
        title: 'Failed',
        middleText: 'Login incorrect',
        textConfirm: 'Try Again',
        confirmTextColor: Colors.white,
        onConfirm: () => Get.back(),
        backgroundColor: Colors.white,
        titleStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      );
    }
  }
}
