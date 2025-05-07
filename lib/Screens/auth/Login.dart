import 'package:MedLife/constant/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/controller/auth_controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/midlife logo.png',
                  height: 150,
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Email',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.check),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => TextField(
                      controller: controller.passwordController,
                      obscureText: controller.obscurePassword.value,
                      decoration: InputDecoration(
                        labelText: 'Enter your Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(controller.obscurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () => controller.togglePasswordVisibility(),
                        ),
                      ),
                    )),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Don't have an account?"),
                    Text("Forget Password",
                        style: TextStyle(color: AppColors.primary)),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => controller.login(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
