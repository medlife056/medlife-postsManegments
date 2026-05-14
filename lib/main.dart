import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:MedLife/Screens/Dev/splashScreen.dart';
import 'package:MedLife/errors/errorsHandler.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      ErrorHandler.init();

      runApp(MyApp());
    },
    (error, stack) {
      debugPrint("ZONE ERROR => $error");
      debugPrintStack(stackTrace: stack);

      ErrorHandler.handle(error);
    },
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedLife',

      // ✅ attach the key so ErrorHandler can show snackbars from anywhere
      scaffoldMessengerKey: ErrorHandler.messengerKey,

      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),

      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),

      home: SplashScreen(),
    );
  }
}
