import 'package:get/get.dart';
import 'package:MedLife/controller/designer/editPost/editPostDesignerService.dart';
import 'package:MedLife/models/editPostModel.dart';

class DesignerPostEditController extends GetxController {
  final PostDesignerService _postService = PostDesignerService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> updatePost(PostUpdateModel updateModel) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _postService.updatePostDesignFields(updateModel);

      Get.snackbar("تم التعديل", "تم تعديل البوست بنجاح");
    } catch (e) {
      errorMessage.value = "فشل في تعديل البوست";
      Get.snackbar("خطأ", errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
