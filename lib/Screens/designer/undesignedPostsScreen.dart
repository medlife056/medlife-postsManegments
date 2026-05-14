import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/Screens/designer/editPostDesignerScreen.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/designer/UndesignedPost/UndesignedPostController.dart';

class UndesignedPostsScreen extends StatelessWidget {
  final int cellId;

  const UndesignedPostsScreen({super.key, required this.cellId});

  @override
  Widget build(BuildContext context) {
    // ✅ put controller inside build, load posts after widget tree is ready
    final controller = Get.put(UndesignedPostController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadPosts(cellId);
    });

    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;

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
                height: widthScreen * 0.1,
              ),
              const SizedBox(width: 10),
              Text(
                "المنشورات غير المصممة",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: widthScreen * 0.05,
                ),
              ),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // ✅ error state with retry button
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
                    onPressed: () => controller.loadPosts(cellId),
                    icon: const Icon(Icons.refresh),
                    label: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          if (controller.posts.isEmpty) {
            return const Center(child: Text('لا يوجد منشورات غير مصممة'));
          }

          return ListView.builder(
            padding: EdgeInsets.all(widthScreen * 0.04),
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];

              return GestureDetector(
                onTap: () {
                  Get.to(() => DesignerEditPostScreen(postId: post.id));
                },
                child: AnimatedScale(
                  scale: 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      title: Text(
                        post.postIdea,
                        style: TextStyle(
                          fontSize: widthScreen * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('كتبه: ${post.writtenBy}'),
                      trailing: Icon(
                        Icons.edit,
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
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
