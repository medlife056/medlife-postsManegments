import 'package:MedLife/controller/getVolunteers/getVolunteersController.dart';
import 'package:MedLife/models/volunteer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/controller/content_Writer/addPost/addPostController.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  final Getvolunteerscontroller volunteerController = Get.put(
    Getvolunteerscontroller(),
  );

  final AddPostController controller = Get.put(AddPostController());

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    final heightScreen = MediaQuery.of(context).size.height;

    final isTablet = widthScreen > 600;

    /// Success Snackbar
    ever(controller.successMessage, (message) {
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message.toString()),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

    /// Error Snackbar
    ever(controller.errorMessage, (message) {
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          title: const Text("كاتب المحتوى"),
          backgroundColor: Colors.white,
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),

          child: ListView(
            children: [
              /// فكرة البوست
              TextField(
                controller: controller.postIdeaController,

                decoration: const InputDecoration(
                  labelText: "فكرة البوست",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              /// Volunteers
              Obx(() {
                final list = volunteerController.volunteers;

                if (volunteerController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (list.isEmpty) {
                  return const Text("لا يوجد متطوعين حالياً");
                }

                return Autocomplete<Volunteer>(
                  optionsBuilder: (TextEditingValue value) {
                    final query = value.text.trim().toLowerCase();

                    if (query.isEmpty) {
                      return list;
                    }

                    return list.where(
                      (v) => v.name.toLowerCase().contains(query),
                    );
                  },

                  displayStringForOption: (Volunteer option) => option.name,

                  fieldViewBuilder: (
                    context,
                    textController,
                    focusNode,
                    onEditingComplete,
                  ) {
                    return TextFormField(
                      controller: textController,

                      focusNode: focusNode,

                      decoration: const InputDecoration(
                        labelText: "اكتب لاختيار متطوع",

                        border: OutlineInputBorder(),
                      ),
                    );
                  },

                  onSelected: (Volunteer selection) {
                    volunteerController.selectedVolunteerId.value =
                        selection.id;
                  },
                );
              }),

              const SizedBox(height: 16),

              /// Coordination
              Obx(
                () => CheckboxListTile(
                  title: const Text("هل يحتاج تنسيق؟"),

                  value: controller.needsCoordination.value,

                  onChanged: (v) {
                    controller.needsCoordination.value = v!;
                  },
                ),
              ),

              /// Design
              Obx(
                () => CheckboxListTile(
                  title: const Text("هل يحتاج تصميم؟"),

                  value: controller.needsDesign.value,

                  onChanged: (v) {
                    controller.needsDesign.value = v!;
                  },
                ),
              ),

              /// Published
              Obx(
                () => CheckboxListTile(
                  title: const Text("تم النشر؟"),

                  value: controller.isPublished.value,

                  onChanged: (v) {
                    controller.isPublished.value = v!;
                  },
                ),
              ),

              const SizedBox(height: 16),

              /// Submit
              Obx(() {
                if (controller.isSubmitting.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ElevatedButton(
                  onPressed: () async {
                    final id = volunteerController.selectedVolunteerId.value;

                    if (id != null) {
                      await controller.submitPost(id);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("الرجاء اختيار المتطوع"),

                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },

                  child: Text(
                    "إضافة البوست",

                    style: TextStyle(
                      fontSize:
                          isTablet ? widthScreen * 0.045 : widthScreen * 0.04,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
