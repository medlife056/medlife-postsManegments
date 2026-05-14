import 'package:get/get.dart';
import 'package:MedLife/controller/content_Writer/editPost/editPostContentWriterService.dart';
import 'package:MedLife/models/editPostModel.dart';

class PostContentWriterEditController extends GetxController {
  final PostContentWriterService _postService = PostContentWriterService();

  var isLoading = false.obs;

  Future<String?> updatePost(PostUpdateModel updateModel) async {
    try {
      isLoading.value = true;

      final success = await _postService.updatePostContentWriterFields(
        updateModel,
      );

      if (success) {
        return "تم تعديل البوست بنجاح";
      }

      return "فشل في تعديل البوست";
    } catch (e) {
      return "حدث خطأ أثناء التعديل";
    } finally {
      isLoading.value = false;
    }
  }
}
