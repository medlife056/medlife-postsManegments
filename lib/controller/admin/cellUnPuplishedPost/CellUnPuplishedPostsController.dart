import 'package:get/get.dart';
import 'package:MedLife/controller/admin/cellUnPuplishedPost/CellUnPuplishedPostsService.dart';
import 'package:MedLife/models/cellUnPuplishedPostModel.dart';

class CellUnPuplishedPostsController extends GetxController {
  final CellUnPuplishedPostsProvider provider;

  CellUnPuplishedPostsController(this.provider);

  var stats = <CellUnPuplishedPostsModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchStats();
    super.onInit();
  }

  @override
void onClose() {
  stats.clear(); // تفريغ البيانات عند الخروج من الشاشة
  super.onClose();
}

  void fetchStats() async {
    try {
      isLoading.value = true;
      stats.value = await provider.fetchCellUnPuplishedPosts();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
