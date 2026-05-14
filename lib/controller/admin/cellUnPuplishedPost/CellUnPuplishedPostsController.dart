import 'package:get/get.dart';
import 'package:MedLife/controller/admin/cellUnPuplishedPost/CellUnPuplishedPostsService.dart';
import 'package:MedLife/models/cellUnPuplishedPostModel.dart';

class CellUnPuplishedPostsController extends GetxController {
  final CellUnPuplishedPostsProvider provider;

  CellUnPuplishedPostsController(this.provider);

  var stats = <CellUnPuplishedPostsModel>[].obs;
  var isLoading = true.obs;

  /// للـ UI
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

      final result =
          await provider.fetchCellUnPuplishedPosts();

      stats.value = result;

      errorMessage.value = null;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}