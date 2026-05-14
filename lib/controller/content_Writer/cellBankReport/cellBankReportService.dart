import 'package:MedLife/models/bankCellReport.dart';
import 'package:http/http.dart' as http;
import 'package:MedLife/constant/Apis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MedLife/errors/errorsHandler.dart';

class CellBankService {
  Future<CellBankStats?> fetchCellBankStats() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('access_token');
      int? cellId = prefs.getInt('cellId');

      final url = Uri.parse('${AppLink.cellBankReport}=$cellId');

      final response = await ErrorHandler.safeApiCall(() {
        return http.get(url, headers: {'Authorization': 'Bearer $token'});
      });

      if (response == null) return null;

      final body = response['body'];

      if (body == null) return null;

      final data = body['data'];

      if (data == null) return null;

      return CellBankStats.fromJson(data);
    } catch (e) {
      print("CELL BANK ERROR => $e");
      return null;
    }
  }
}
