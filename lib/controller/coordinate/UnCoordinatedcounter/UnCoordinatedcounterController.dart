import 'package:get/get.dart';
import 'package:MedLife/controller/coordinate/UnCoordinatedcounter/UnCoordinatedcounterservice.dart';
import 'package:MedLife/models/uncoordinatedCounterModel.dart';

class UnCoordinatercounterController extends GetxController {
  final UncoordinatecounterProvider provider;

  UnCoordinatercounterController(this.provider);

  var stats = <UnCoordinatedcounterModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadStats();
  }

  @override
  void onReady() {
    super.onReady();
    loadStats(); // كل مرة ترجع للواجهة رح تنعاد
  }

  @override
  void onClose() {
    super.onClose();
    stats.clear();
  }

  void loadStats() async {
    isLoading.value = true;
    stats.value = await provider.fetchUncoordinatePosts();
    isLoading.value = false;
  }
}
