import 'package:http/http.dart' as http;
import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await ErrorHandler.safeApiCall(() {
        return http.post(
          Uri.parse(AppLink.login),
          body: {'name': email, 'password': password},
        );
      });

      print("FULL RESPONSE => $response");

      if (response == null) {
        return null;
      }

      final data = response['body']['data'];
      print(data);
      print('gdflkgjslkdfjglksjfldgjsd');
      print(response['data']);
      if (data == null) {
        return null;
      }

      final token = data['token'];
      final role = data['role'];
      final int cellId = int.tryParse(data['id'].toString()) ?? 0;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('access_token', token ?? '');
      // ignore: dead_null_aware_expression
      await prefs.setInt('cellId', cellId ?? 0);
      await prefs.setString('role', role ?? '');

      return {"token": token, "role": role};
    } catch (e) {
      print("LOGIN ERROR => $e");
      return null;
    }
  }
}
