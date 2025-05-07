import 'package:get/get.dart';
import 'package:MedLife/controller/content_Writer/cellBankReport/cellBankReportService.dart';
import 'package:MedLife/models/bankCellReport.dart';

class CellBankController extends GetxController {
  final CellBankService _service = CellBankService();

  var stats = Rxn<CellBankStats>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void onInit() {
    super.onInit();
    loadStats();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   loadStats();
  // }

  Future<void> loadStats() async {
    final start = DateTime.now(); // ⏱️ بداية القياس
    isLoading.value = true;
    try {
      stats.value = await _service.fetchCellBankStats();
    } catch (e) {
      errorMessage.value = 'فشل في تحميل تقرير بنك الخلية';
    } finally {
      isLoading.value = false;
      final end = DateTime.now(); // ⏱️ نهاية القياس
      print(
        "📊 زمن تحميل تقرير بنك الخلية: ${end.difference(start).inMilliseconds} ms",
      );
    }
  }
}
