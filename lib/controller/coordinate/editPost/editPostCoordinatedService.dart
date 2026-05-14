import 'dart:convert';
import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/models/editPostModel.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostService {
  Future<bool> updatePostCoordinatedFields(PostUpdateModel post) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    final url = Uri.parse('${AppLink.editPost}/${post.id}');

    final response = await ErrorHandler.safeApiCall(() {
      return http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'is_coordinated': post.isCoordinated,
          'coordinated_by': post.coordinatedBy,
          'coordinated_at': post.coordinatedAt?.toIso8601String(),
        }),
      );
    });

    if (response == null) return false;

    final statusCode = response['statusCode'];
    final body = response['body'];

    if (body == null) return false;

    if (statusCode == 200 || statusCode == 201) return true;

    final message = body['message']?.toString().toLowerCase() ?? '';
    if (message.contains('success') || message.contains('updated')) return true;

    return false;
  }
}
