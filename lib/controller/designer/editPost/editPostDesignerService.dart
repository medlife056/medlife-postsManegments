import 'dart:convert';
import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/models/editPostModel.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostDesignerService {
  Future<bool> updatePostDesignFields(PostUpdateModel post) async {
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
          'is_designed': post.isDesigned,
          'designed_by': post.designedBy,
          'designed_at': post.designedAt?.toIso8601String(),
        }),
      );
    });

    if (response == null) return false;

    try {
      if (response['message'] == 'Post updated successfully.') {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
