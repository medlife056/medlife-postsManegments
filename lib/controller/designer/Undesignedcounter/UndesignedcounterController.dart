import 'package:get/get.dart';
import 'package:MedLife/controller/designer/Undesignedcounter/Undesignedcounterservice.dart';
import 'package:MedLife/models/undesignedCounterModel.dart';

class UndesignedcounterController extends GetxController {
  final UndesignedcounterProvider provider;

  UndesignedcounterController(this.provider);

  var stats = <UndesignedcounterModel>[].obs;
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
    stats.value = await provider.fetchUndesignedPosts();
    isLoading.value = false;
  }
}
