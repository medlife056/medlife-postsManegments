import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:MedLife/models/cellModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DesignerService {
  Future<List<CellModel>> fetchCells() async {

SharedPreferences prefs = await SharedPreferences.getInstance();
   String? token = prefs.getString('access_token');

    final response = await ErrorHandler.safeApiCall(() {
      return http.get(
        Uri.parse(AppLink.showCells),
        headers: {
          'Authorization':
              'Bearer $token',
        },
      );
    });

    if (response == null) return [];

    if (response['data'] != null) {
      final List data = response['data'];
      return data.map((e) => CellModel.fromJson(e)).toList();
    }

    return [];
  }
}
