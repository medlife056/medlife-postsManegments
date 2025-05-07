import 'package:get/get.dart';
import 'package:MedLife/controller/admin/cellStatePostReport/cellStatePostService.dart';
import 'package:MedLife/models/cellStatePostModel.dart';

class CellPostsStatsController extends GetxController {
  final CellPostsProvider provider;

  CellPostsStatsController(this.provider);

  var stats = <CellPostsStatsModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchStats();
    super.onInit();
  }

  @override
  void onClose() {
    stats.clear(); 
    super.onClose();
  }

  void fetchStats() async {
    try {
      isLoading.value = true;
      stats.value = await provider.fetchCellPostsStats();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
