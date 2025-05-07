import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';

import 'package:MedLife/models/readyPostsModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReadyPostsService {
  Future<List<ReadyPostModel>> fetchReadyPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    final response = await ErrorHandler.safeApiCall(() {
      return http.get(
        Uri.parse(AppLink.readyPosts),
        headers: {'Authorization': 'Bearer $token'},
      );
    });

    print(response['data']);
    if (response == null) return [];

    if (response['data'] != null && response['data'] is List) {
      final List data = response['data'];
      return data.map((e) => ReadyPostModel.fromJson(e)).toList();
    }

    return [];
  }
}
