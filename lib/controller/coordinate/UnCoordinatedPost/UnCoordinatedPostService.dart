import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:MedLife/models/postModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class UncoordinatePostService {
  Future<List<PostModel>> fetchUncoordinatePosts(int cellId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    final response = await ErrorHandler.safeApiCall(() {
      return http.get(
        Uri.parse('${AppLink.UnCoordinatedPost}=$cellId'),
        headers: {
          'Authorization':
              'Bearer $token',
        },
      );
    });
    print(response['data']);
    if (response == null) return [];

    if (response['data'] != null) {
      final List data = response['data'];
      return data.map((e) => PostModel.fromJson(e)).toList();
    }

    return [];
  }
}
