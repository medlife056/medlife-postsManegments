import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:MedLife/models/cellUnPuplishedPostModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class CellUnPuplishedPostsProvider {
  Future<List<CellUnPuplishedPostsModel>> fetchCellUnPuplishedPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   String? token = prefs.getString('access_token');

    final response = await ErrorHandler.safeApiCall(() {
      return http.get(
        Uri.parse(AppLink.cellUnPuplishedPosts),
        headers: {'Authorization': 'Bearer $token'},
      );
    });

    if (response == null) return [];

    if (response['data'] != null && response['data'] is List) {
      final List data = response['data'];
      return data.map((e) => CellUnPuplishedPostsModel.fromJson(e)).toList();
    }

    return [];
  }
}
