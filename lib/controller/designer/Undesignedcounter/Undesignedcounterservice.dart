import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:MedLife/models/undesignedCounterModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UndesignedcounterProvider {
  Future<List<UndesignedcounterModel>> fetchUndesignedPosts() async {


SharedPreferences prefs = await SharedPreferences.getInstance();
   String? token = prefs.getString('access_token');

    final response = await ErrorHandler.safeApiCall(() {
      return http.get(
        Uri.parse(AppLink.cellUnDesignedCounter),
        headers: {
          'Authorization':
              'Bearer $token',
        },
      );
    });

    if (response == null) return [];

    if (response is List) {
      return response.map((e) => UndesignedcounterModel.fromJson(e)).toList();
    } else if (response['data'] != null) {
      final List stats = response['data'];
      return stats.map((e) => UndesignedcounterModel.fromJson(e)).toList();
    }

    return [];
  }
}
