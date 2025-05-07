import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/admin/createWriter/createWriterController.dart';

class CreateWriterScreen extends StatelessWidget {
  final CreateWriterController controller = Get.put(CreateWriterController());
  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(widthScreen * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: heightScreen * 0.03),
                  Image.asset(
                    'assets/images/midlife logo.png',
                    height: heightScreen * 0.3,
                  ),
                  SizedBox(height: heightScreen * 0.03),

                  // Username Field
                  TextField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      labelText: 'ادخل اسم المستخدم',
                      border: const UnderlineInputBorder(),
                      suffixIcon: const Icon(Icons.person),
                    ),
                    style: TextStyle(fontSize: widthScreen * 0.04),
                  ),
                  SizedBox(height: heightScreen * 0.02),

                  // Password Field
                  Obx(
                    () => TextField(
                      controller: controller.passwordController,
                      obscureText: controller.obscurePassword.value,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        border: const UnderlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                      style: TextStyle(fontSize: widthScreen * 0.04),
                    ),
                  ),
                  SizedBox(height: heightScreen * 0.02),

                  // Confirm Password Field
                  Obx(
                    () => TextField(
                      controller: controller.confirmPasswordController,
                      obscureText: controller.obscurePassword.value,
                      decoration: const InputDecoration(
                        labelText: 'تأكيد كلمة المرور',
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.lock),
                      ),
                      style: TextStyle(fontSize: widthScreen * 0.04),
                    ),
                  ),
                  SizedBox(height: heightScreen * 0.04),

                  // Register Button
                  Obx(
                    () => ElevatedButton(
                      onPressed:
                          controller.isLoading.value
                              ? null
                              : controller.register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(
                          horizontal: widthScreen * 0.1,
                          vertical: heightScreen * 0.015,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child:
                          controller.isLoading.value
                              ? SizedBox(
                                width: widthScreen * 0.06,
                                height: widthScreen * 0.06,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                'انشاء حساب',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: widthScreen * 0.045,
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
