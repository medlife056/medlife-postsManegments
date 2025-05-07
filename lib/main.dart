import 'package:MedLife/Screens/Dev/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/errors/errorsHandler.dart';

void main() {
  ErrorHandler.init();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Posts Management',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: SplashScreen(),
    );
  }
}
