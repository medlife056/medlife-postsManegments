import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:MedLife/Screens/auth/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';

class LogoutService {
  Future<bool> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      final response = await ErrorHandler.safeApiCall(() {
        return http.get(
          Uri.parse(AppLink.logout),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );
      });

      print("LOGOUT RESPONSE => $response");

      if (response == null) return false;

      final message = response['body']['message'];

      if (message == "Logged out successfully") {
        await prefs.clear();

        Get.offAll(() => LoginScreen());

        return true;
      }

      return false;
    } catch (e) {
      print("LOGOUT ERROR => $e");
      return false;
    }
  }
}