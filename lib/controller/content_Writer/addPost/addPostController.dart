import 'package:MedLife/controller/getVolunteers/getVolunteersController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/controller/content_Writer/addPost/addPostService.dart';


class AddPostController extends GetxController {
  final postIdeaController = TextEditingController();

  var needsCoordination = false.obs;
  var needsDesign = false.obs;
  var isPublished = false.obs;
  var isSubmitting = false.obs;

  late Getvolunteerscontroller volunteerController;

  @override
  void onInit() {
    super.onInit();
    volunteerController = Get.find<Getvolunteerscontroller>();
  }

  Future<void> submitPost(int volunteerId) async {
    final idea = postIdeaController.text.trim();

    if (idea.isEmpty) {
      Get.snackbar("تنبيه", "اكتب فكرة البوست");
      return;
    }

    isSubmitting.value = true;

    try {
      final response = await AddPostService().addPost(
        idea,
        volunteerId,
        needsCoordination.value,
        needsDesign.value,
        isPublished.value,
      );

      if (response != null) {
        Get.snackbar("تم", "تمت إضافة البوست بنجاح");

        /// reset state
        postIdeaController.clear();
        needsCoordination.value = false;
        needsDesign.value = false;
        isPublished.value = false;
        volunteerController.selectedVolunteerId.value = null;
      } else {
        Get.snackbar("خطأ", "فشل إضافة البوست");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الإرسال");
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    postIdeaController.dispose();
    super.onClose();
  }
}