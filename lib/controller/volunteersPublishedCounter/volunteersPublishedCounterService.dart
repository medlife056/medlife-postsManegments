import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:MedLife/models/volunteersDesign.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetVolunteersDesignedCounter {
  Future<List<VolunteerDesignedCounter>> fetchVolunteersDesignCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    final url = Uri.parse(AppLink.UndesignedPost);

    final response = await ErrorHandler.safeApiCall(() {
      return http.get(url, headers: {'Authorization': 'Bearer $token'});
    });

    if (response == null) return [];
    if (response['data'] != null) {
      final List data = response['data'];
      return data.map((e) => VolunteerDesignedCounter.fromJson(e)).toList();
    }

    return [];
  }
}
