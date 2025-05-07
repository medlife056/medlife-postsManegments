import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:MedLife/models/volunteer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Getvolunteersservice {
  Future<List<Volunteer>> getVolunteers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    final url = Uri.parse(AppLink.volunteer);

    final response = await ErrorHandler.safeApiCall(() {
      return http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
    });

    if (response == null) return [];

    try {
      final List data = response['data']['data'];
      return data.map((v) => Volunteer.fromJson(v)).toList();
    } catch (e) {
      return [];
    }
  }
}
