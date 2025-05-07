import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/models/cellStatePostModel.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class CellPostsProvider {
  Future<List<CellPostsStatsModel>> fetchCellPostsStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   String? token = prefs.getString('access_token');

    final response = await ErrorHandler.safeApiCall(() {
      return http.get(
        Uri.parse(AppLink.cellsWithNumberOfPublishedPosts),
        headers: {'Authorization': 'Bearer $token'},
      );
    });

    // تحقق من الاستجابة والبيانات
    if (response != null &&
        response['data'] != null &&
        response['data'] is List) {
      final List data = response['data'];
      return data.map((e) => CellPostsStatsModel.fromJson(e)).toList();
    }

    return []; // في حال وجود أي خطأ أو غياب البيانات
  }
}
