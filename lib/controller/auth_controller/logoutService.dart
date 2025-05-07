import 'package:get/get.dart';
import 'package:MedLife/Screens/auth/Login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';

class LogoutService {
  Future<bool> logout() async {
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

    if (response == null) return false;

    if (response['message'] == "Logged out successfully") {
      await prefs.remove('access_token');
      await prefs.remove('cellId');

      Get.snackbar("نجاح", "تم تسجيل الخروج بنجاح");
      Get.offAll(LoginScreen());
      return true;
    }

    return false;
  }
}
