import 'package:get/get.dart';
import 'package:MedLife/controller/content_Writer/cellVolunteerReport/cellVolunteerReportservice.dart';
import 'package:MedLife/models/cellVolunteerReportModel.dart';

class CellVolunteersReportController extends GetxController {
  var volunteers = <CellVolunteerReportModel>[].obs;
  var isLoading = false.obs;

  final service = CellVolunteersReportService();

  @override
  void onInit() {
    super.onInit();
    fetchReport();
  }

  @override
  void onReady() {
    super.onReady();
    fetchReport(); // كل مرة ترجع للواجهة رح تنعاد
  }

  @override
  void onClose() {
    super.onClose();
    volunteers.clear();
  }

  void fetchReport() async {
    isLoading.value = true;
    try {
      final data = await service.fetchVolunteersReport();
      volunteers.value = data;
    } catch (e) {
      Get.snackbar('خطأ', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
