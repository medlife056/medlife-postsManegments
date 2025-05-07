import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/controller/content_Writer/addPost/addPostService.dart';

class AddPostController extends GetxController {
  final postIdeaController = TextEditingController();
  var needsCoordination = false.obs;
  var needsDesign = false.obs;
  var isPublished = false.obs;
  var isSubmitting = false.obs;


   @override
  void onReady() {
    super.onReady();
    // إعادة تعيين القيم عند كل فتح للشاشة
    postIdeaController.clear();
    needsCoordination.value = false;
    needsDesign.value = false;
    isPublished.value = false;
  }

  Future<void> submitPost(int volunteerId) async {
    isSubmitting.value = true;
    try {
      final idea = postIdeaController.text;
      // ignore: unused_local_variable
      final response = await AddPostService().addPost(
        idea,
        volunteerId,
        needsCoordination.value,
        needsDesign.value,
        isPublished.value,
      );
      Get.snackbar("تم", "تمت إضافة البوست بنجاح");
      postIdeaController.clear();
      needsCoordination.value = false;
      needsDesign.value = false;
      isPublished.value = false;
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    } finally {
      isSubmitting.value = false;
    }
  }
}
