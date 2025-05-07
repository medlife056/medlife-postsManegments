import 'package:get/get.dart';
import 'package:MedLife/controller/designer/showcellcontroller/cellService.dart';
import 'package:MedLife/models/cellModel.dart';

class DesignerCellsController extends GetxController {
  var cells = <CellModel>[].obs;
  var isLoading = true.obs;

  final DesignerService _service = DesignerService();

  @override
  void onInit() {
    super.onInit();
    loadCells();
  }

  @override
  void onReady() {
    super.onReady();
    loadCells(); // كل مرة ترجع للواجهة رح تنعاد
  }

  @override
  void onClose() {
    super.onClose();
    cells.clear();
  }

  void loadCells() async {
    try {
      isLoading(true);
      cells.value = await _service.fetchCells();
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في جلب البيانات');
    } finally {
      isLoading(false);
    }
  }
}
