import 'package:MedLife/constant/Apis.dart';
import 'package:MedLife/errors/errorsHandler.dart';
import 'package:MedLife/models/cellVolunteerReportModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CellVolunteersReportService {
  Future<List<CellVolunteerReportModel>> fetchVolunteersReport() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('access_token');

      int? cellId = prefs.getInt('cellId');

      final response = await ErrorHandler.safeApiCall(() {
        return http.get(
          Uri.parse('${AppLink.cellVolunteersReport}=$cellId'),
          headers: {'Authorization': 'Bearer $token'},
        );
      });

      if (response == null) return [];

      final body = response['body'];

      if (body == null) return [];

      final data = body['data'];

      if (data == null || data is! List) {
        return [];
      }

      return data
          .map<CellVolunteerReportModel>(
            (e) => CellVolunteerReportModel.fromJson(e),
          )
          .toList();
    } catch (e) {
      print("VOLUNTEERS REPORT ERROR => $e");
      return [];
    }
  }
}
