import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:MedLife/models/cellVolunteerReportModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CellVolunteersReportService {
  Future<List<CellVolunteerReportModel>> fetchVolunteersReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    int? cellId = prefs.getInt('cellId');
print(cellId);
    final response = await ErrorHandler.safeApiCall(() {
      return http.get(
        Uri.parse('${AppLink.cellVolunteersReport}=$cellId'),
        headers: {'Authorization': 'Bearer $token'},
      );
    });
    print(response['data']);
    if (response == null) return [];

    if (response['data'] != null && response['data'] is List) {
      final List data = response['data'];
      return data.map((e) => CellVolunteerReportModel.fromJson(e)).toList();
    }

    return [];
  }
}
