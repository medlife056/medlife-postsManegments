import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/controller/designer/editPost/editPostDesignerService.dart';
import 'package:MedLife/models/editPostModel.dart';

class DesignerPostEditController extends GetxController {
  final PostDesignerService _postService = PostDesignerService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> updatePost(
    PostUpdateModel updateModel,
    BuildContext context,
  ) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final success = await _postService.updatePostDesignFields(updateModel);

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
