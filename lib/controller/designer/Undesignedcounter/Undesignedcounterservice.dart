// ignore_for_file: unnecessary_cast

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
        headers: {'Authorization': 'Bearer $token'},
      );
    });

    if (response == null) return [];

    final body = response['body'];
    if (body == null) return [];

    if (body is List) {
      return (body as List)
          .map(
            (e) => UndesignedcounterModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    }

    final data = body['data'];
    if (data != null && data is List) {
      return (data as List)
          .map(
            (e) => UndesignedcounterModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    }

    return [];
  }
}
