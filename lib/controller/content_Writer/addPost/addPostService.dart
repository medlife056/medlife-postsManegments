import 'package:http/http.dart' as http;
import 'package:MedLife/constant/Apis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MedLife/errors/errorsHandler.dart';

class AddPostService {
  Future<bool> addPost(
    String postIdea,
    int writtenBy,
    bool needsCoordination,
    bool needsDesign,
    bool isPublished,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    final response = await ErrorHandler.safeApiCall(() {
      return http.post(
        Uri.parse(AppLink.addPost),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'post_idea': postIdea,
          'written_by': writtenBy.toString(),
          'need_coordination': needsCoordination ? '1' : '0',
          'need_design': needsDesign ? '1' : '0',
          'is_published': isPublished ? '1' : '0',
        },
      );
    });

    if (response == null) return false;

    // تحقق من وجود message أو نجاح الإضافة
    if (response['message'] != null &&
        response['message'].toString().toLowerCase().contains('success')) {
      return true;
    }

    return false;
  }
}
