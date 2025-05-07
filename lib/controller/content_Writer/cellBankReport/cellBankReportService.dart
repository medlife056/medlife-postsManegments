import 'package:MedLife/models/bankCellReport.dart';
import 'package:http/http.dart' as http;
import 'package:MedLife/constant/Apis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MedLife/errors/errorsHandler.dart';

class CellBankService {
  Future<CellBankStats?> fetchCellBankStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    int? cellId = prefs.getInt('cellId');
    print(cellId);
    final url = Uri.parse('${AppLink.cellBankReport}=$cellId');

    final response = await ErrorHandler.safeApiCall(() {
      return http.get(url, headers: {'Authorization': 'Bearer $token'});
    });

    if (response == null) return null;

    try {
      final data = response['data'];
      return CellBankStats.fromJson(data);
    } catch (e) {
      // معالجة في حال فشل التحويل من JSON
      return null;
    }
  }
}
