import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:MedLife/models/cellModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CoordinaterService {
  Future<List<CellModel>> fetchCells() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    final response = await ErrorHandler.safeApiCall(() {
      return http.get(
        Uri.parse(AppLink.showCells),
        headers: {'Authorization': 'Bearer $token'},
      );
    });

    if (response == null) return [];

    final body = response['body']; // ✅ access body first
    if (body == null) return [];

    final data = body['data'];
    if (data == null || data is! List) return [];

    // ignore: unnecessary_cast
    return (data as List)
        .map((e) => CellModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
