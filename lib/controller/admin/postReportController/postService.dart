import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:MedLife/models/postModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class PostProvider {
  Future<List<PostModel>> fetchPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   String? token = prefs.getString('access_token');

    final response = await ErrorHandler.safeApiCall(() {
      return http.get(
        Uri.parse(AppLink.postsReport),
        headers: {'Authorization': 'Bearer $token'},
      );
    });

    // تأكد إن الاستجابة مو null
    if (response == null) return [];

    // هون `safeApiCall` بيرجع Json مفكوك جاهز، مش response كامل
    if (response is List) {
      return response.map((e) => PostModel.fromJson(e)).toList();
    } else if (response['data'] != null) {
      final List posts = response['data'];
      return posts.map((e) => PostModel.fromJson(e)).toList();
    }

    // في حال كانت الاستجابة غير متوقعة
    return [];
  }
}
