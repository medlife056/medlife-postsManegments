import 'package:get/get.dart';
import 'package:MedLife/controller/coordinate/showcellcontroller/cellService.dart';
import 'package:MedLife/models/cellModel.dart';

class CoordinaterCellsController extends GetxController {
  var cells = <CellModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs; // ✅ added for UI error display

  final CoordinaterService _service = CoordinaterService();

  @override
  void onReady() {
    super.onReady();
    loadCells(); // ✅ only onReady, removed onInit to avoid double fetch
  }

  @override
  void onClose() {
    cells.clear();
    super.onClose();
  }

  Future<void> loadCells() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final data = await _service.fetchCells();
      cells.value = data;

      if (data.isEmpty) {
        errorMessage.value = 'لا توجد خلايا حالياً';
      }
    } catch (e) {
      errorMessage.value = 'فشل في جلب البيانات';
    } finally {
      isLoading.value = false;
    }
  }
}
