import 'package:get/get.dart';
import 'package:MedLife/controller/content_Writer/cellBankReport/cellBankReportService.dart';
import 'package:MedLife/models/bankCellReport.dart';

class CellBankController extends GetxController {
  final CellBankService _service = CellBankService();

  var stats = Rxn<CellBankStats>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadStats(); // ✅ moved from onInit to onReady
  }

  Future<void> loadStats() async {
    final start = DateTime.now();

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _service.fetchCellBankStats();

      if (result != null) {
        stats.value = result;
      } else {
        errorMessage.value = 'لا توجد بيانات';
      }
    } catch (e) {
      errorMessage.value = 'فشل في تحميل تقرير بنك الخلية';
    } finally {
      isLoading.value = false;

      final end = DateTime.now();

      print(
        "📊 زمن تحميل تقرير بنك الخلية: ${end.difference(start).inMilliseconds} ms",
      );
    }
  }
}
