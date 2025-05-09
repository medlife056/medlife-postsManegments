import 'dart:async';
import 'package:MedLife/Screens/admin/admin_home.dart';
import 'package:MedLife/Screens/auth/Login.dart';
import 'package:MedLife/Screens/content_writer/contentWriterHomeScreen.dart';
import 'package:MedLife/Screens/coordinater/coordinater_home.dart';
import 'package:MedLife/Screens/designer/designer_home.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');
      String? role = prefs.getString('role');

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
        }
      } else {
        Get.offAll(() => LoginScreen());
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isTablet = width > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/midlife logo.png',
                height: isTablet ? height * 0.5 : height * 0.35,
              ),
              const SizedBox(height: 20),
              Text(
                'MedLife Team',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isTablet ? width * 0.10 : width * 0.10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
