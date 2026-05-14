import 'package:get/get.dart';
import 'package:MedLife/controller/admin/cellStatePostReport/cellStatePostService.dart';
import 'package:MedLife/models/cellStatePostModel.dart';

class CellPostsStatsController extends GetxController {
  final CellPostsProvider provider;

  CellPostsStatsController(this.provider);

  var stats = <CellPostsStatsModel>[].obs;
  var isLoading = true.obs;

  /// بدل snackbar
  var errorMessage = RxnString();

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

  Future<void> fetchStats() async {
    try {
      isLoading.value = true;

      final result = await provider.fetchCellPostsStats();

      stats.value = result;

      errorMessage.value = null;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}