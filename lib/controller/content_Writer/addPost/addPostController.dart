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

  /// UI Messages
  var successMessage = RxnString();

  var errorMessage = RxnString();

  late Getvolunteerscontroller volunteerController;

  @override
  void onInit() {
    super.onInit();

    volunteerController = Get.find<Getvolunteerscontroller>();
  }

  Future<bool> submitPost(int volunteerId) async {
    final idea = postIdeaController.text.trim();

    if (idea.isEmpty) {
      errorMessage.value = "اكتب فكرة البوست";

      return false;
    }

    isSubmitting.value = true;

    try {
      final success = await AddPostService().addPost(
        idea,
        volunteerId,
        needsCoordination.value,
        needsDesign.value,
        isPublished.value,
      );

      if (success) {
        successMessage.value = "تمت إضافة البوست بنجاح";

        /// reset
        postIdeaController.clear();

        needsCoordination.value = false;

        needsDesign.value = false;

        isPublished.value = false;

        volunteerController.selectedVolunteerId.value = null;

        return true;
      }

      errorMessage.value = "فشل إضافة البوست";

      return false;
    } catch (e) {
      errorMessage.value = "حدث خطأ أثناء الإرسال";

      return false;
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
