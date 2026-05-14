import 'package:get/get.dart';
import 'package:MedLife/controller/coordinate/UnCoordinatedcounter/UnCoordinatedcounterservice.dart';
import 'package:MedLife/models/uncoordinatedCounterModel.dart';

class UnCoordinatercounterController extends GetxController {
  final UncoordinatecounterProvider provider;

  UnCoordinatercounterController(this.provider);

  var stats = <UnCoordinatedcounterModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs; // ✅ added for UI error display

  @override
  void onReady() {
    super.onReady();
    loadStats(); // ✅ only onReady, removed onInit to avoid double fetch
  }

  @override
  void onClose() {
    stats.clear();
    super.onClose();
  }

  Future<void> loadStats() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final data = await provider.fetchUncoordinatePosts();
      stats.value = data;

      if (data.isEmpty) {
        errorMessage.value = 'لا توجد بيانات حالياً';
      }
    } catch (e) {
      errorMessage.value = 'فشل في جلب البيانات';
    } finally {
      isLoading.value = false;
    }
  }
}
