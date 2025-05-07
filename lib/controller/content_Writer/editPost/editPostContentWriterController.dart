import 'package:get/get.dart';
import 'package:MedLife/controller/content_Writer/editPost/editPostContentWriterService.dart';
import 'package:MedLife/models/editPostModel.dart';

class PostContentWriterEditController extends GetxController {
  final PostContentWriterService _postService = PostContentWriterService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> updatePost(PostUpdateModel updateModel) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _postService.updatePostContentWriterFields(updateModel);

      Get.snackbar("تم التعديل", "تم تعديل البوست بنجاح");
    } catch (e) {
      errorMessage.value = "فشل في تعديل البوست";
      Get.snackbar("خطأ", errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
