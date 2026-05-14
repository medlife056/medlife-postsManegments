import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/Screens/content_writer/editPostContentWriterScreen.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/content_Writer/readyPosts/readyPostsController.dart';

class ReadyPostScreen extends StatelessWidget {
  const ReadyPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ put controller inside build, not as a field
    final controller = Get.put(ReadyPostController());

    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final isTablet = widthScreen > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          title: Row(
            children: [
              Image.asset(
                'assets/images/midlife logo.png',
                height: isTablet ? heightScreen * 0.08 : heightScreen * 0.05,
              ),
              const SizedBox(width: 10),
              Text(
                "المنشورات الجاهزة للنشر",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: isTablet ? widthScreen * 0.06 : widthScreen * 0.05,
                ),
              ),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // ✅ show error in UI instead of ever() snackbar
          if (controller.errorMessage.value.isNotEmpty &&
              controller.posts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => controller.fetchPosts(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          if (controller.posts.isEmpty) {
            return const Center(child: Text("لا يوجد منشورات جاهزة"));
          }

          return ListView.builder(
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];

              return Card(
                margin: EdgeInsets.all(
                  isTablet ? heightScreen * 0.02 : heightScreen * 0.01,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.postIdea,
                        style: TextStyle(
                          fontSize:
                              isTablet
                                  ? widthScreen * 0.05
                                  : widthScreen * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text("الكاتب: ${post.writtenBy}"),
                      Text("منسق: ${post.coordinatedBy}"),
                      Text("مصمم: ${post.designedBy}"),
                      Text("الخليّة: ${post.cellId}"),
                      Text("تاريخ التنسيق: ${post.coordinatedAt}"),
                      Text("تاريخ التصميم: ${post.designedAt}"),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Get.to(
                              () =>
                                  ContentWriterEditPostScreen(postId: post.id),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          icon: const Icon(Icons.edit),
                          label: const Text(
                            "تعديل",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
