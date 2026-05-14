import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/controller/coordinate/editPost/editPostCoordinatedService.dart';
import 'package:MedLife/models/editPostModel.dart';

class PostEditController extends GetxController {
  final PostService _postService = PostService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> updatePost(
    PostUpdateModel updateModel,
    BuildContext context,
  ) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final success = await _postService.updatePostCoordinatedFields(
        updateModel,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تعديل البوست بنجاح'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Get.back();
      } else {
        errorMessage.value = 'فشل في تعديل البوست';
      }
    } catch (e) {
      errorMessage.value = 'حدث خطأ أثناء التعديل';
    } finally {
      isLoading.value = false;
    }
  }
}
