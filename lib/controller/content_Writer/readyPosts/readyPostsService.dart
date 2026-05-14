import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:MedLife/models/readyPostsModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReadyPostsService {
  Future<List<ReadyPostModel>> fetchReadyPosts() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    String? token = prefs.getString('access_token');

    final response = await ErrorHandler.safeApiCall(() {
      return http.get(
        Uri.parse(AppLink.readyPosts),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
    });

    if (response == null) {
      throw Exception("فشل الاتصال بالسيرفر");
    }

    final body = response['body'];

    if (body == null) {
      throw Exception("البيانات فارغة");
    }

    final data = body['data'];

    if (data != null && data is List) {
      return data
          .map((e) => ReadyPostModel.fromJson(e))
          .toList();
    }

    return [];
  }
}