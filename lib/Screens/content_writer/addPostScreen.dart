import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/content_Writer/addPost/addPostController.dart';
import '../../controller/getVolunteers/getVolunteersController.dart';

class AddPostScreen extends StatelessWidget {
  final AddPostController controller = Get.put(AddPostController());
  final Getvolunteerscontroller volunteerController = Get.put(
    Getvolunteerscontroller(),
  );

  AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;

    final isTablet = widthScreen > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Image.asset(
                'assets/images/midlife logo.png',
                height: isTablet ? heightScreen * 0.08 : heightScreen * 0.05,
              ),
              const SizedBox(width: 10),
              Text(
                "كاتب المحتوى",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: isTablet ? widthScreen * 0.06 : widthScreen * 0.05,
                ),
              ),
            ],
          ),
        ),
        body: Obx(() {
          if (volunteerController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widthScreen * 0.05,
              vertical: 16,
            ),
            child: ListView(
              children: [
                TextField(
                  controller: controller.postIdeaController,
                  decoration: const InputDecoration(labelText: "فكرة البوست"),
                ),
                const SizedBox(height: 16),
           Autocomplete<String>(
  optionsBuilder: (TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return const Iterable<String>.empty();
    }

    return volunteerController.volunteers
        .map((v) => v.name)
        .where((name) => name
            .toLowerCase()
            .startsWith(textEditingValue.text.toLowerCase()));
  },
  displayStringForOption: (option) => option,
  fieldViewBuilder:
      (context, textEditingController, focusNode, onEditingComplete) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      decoration: const InputDecoration(
        labelText: "اختر المتطوع",
        border: OutlineInputBorder(),
      ),
    );
  },
  onSelected: (String selection) {
    final selectedVolunteer = volunteerController.volunteers
        .firstWhere((v) => v.name == selection);

    volunteerController.selectedVolunteerId.value =
        selectedVolunteer.id;
  },
)
,
                const SizedBox(height: 16),
                Obx(
                  () => CheckboxListTile(
                    title: const Text("هل يحتاج تنسيق؟"),
                    value: controller.needsCoordination.value,
                    onChanged: (v) => controller.needsCoordination.value = v!,
                  ),
                ),
                Obx(
                  () => CheckboxListTile(
                    title: const Text("هل يحتاج تصميم؟"),
                    value: controller.needsDesign.value,
                    onChanged: (v) => controller.needsDesign.value = v!,
                  ),
                ),
                Obx(
                  () => CheckboxListTile(
                    title: const Text("تم النشر؟"),
                    value: controller.isPublished.value,
                    onChanged: (v) => controller.isPublished.value = v!,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () =>
                      controller.isSubmitting.value
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () async {
                                final id =
                                    volunteerController.selectedVolunteerId.value;
                                if (id != null) {
                                  await controller.submitPost(id);
                                } else {
                                  Get.snackbar("خطأ", "الرجاء اختيار المتطوع");
                                }
                              },
                              child: Text(
                                "إضافة البوست",
                                style: TextStyle(
                                  fontSize: isTablet ? widthScreen * 0.045 : widthScreen * 0.04,
                                ),
                              ),
                            ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
