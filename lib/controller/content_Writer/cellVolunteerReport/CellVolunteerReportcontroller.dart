import 'package:get/get.dart';
import 'package:MedLife/controller/content_Writer/cellVolunteerReport/cellVolunteerReportservice.dart';
import 'package:MedLife/models/cellVolunteerReportModel.dart';

class CellVolunteersReportController extends GetxController {
  var volunteers = <CellVolunteerReportModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final service = CellVolunteersReportService();

  @override
  void onReady() {
    super.onReady();
    fetchReport(); // ✅ @override was missing before
  }

  @override
  void onClose() {
    volunteers.clear();
    super.onClose();
  }

  void fetchReport() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final data = await service.fetchVolunteersReport();
      volunteers.value = data;

      if (data.isEmpty) {
        errorMessage.value = 'لا يوجد بيانات حالياً';
      }
    } catch (e) {
      errorMessage.value = 'تحقق من اتصال الإنترنت';
    } finally {
      isLoading.value = false;
    }
  }
}
