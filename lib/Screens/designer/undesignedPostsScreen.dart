import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/Screens/designer/editPostDesignerScreen.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/designer/UndesignedPost/UndesignedPostController.dart';

class UndesignedPostsScreen extends StatelessWidget {
  final int cellId;
  final controller = Get.put(UndesignedPostController());

  UndesignedPostsScreen({required this.cellId}) {
    controller.loadPosts(cellId);
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    final heightScreen = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Image.asset('assets/images/midlife logo.png', height: widthScreen * 0.1),
              SizedBox(width: 10),
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
            return Center(child: CircularProgressIndicator());
          }
          if (controller.posts.isEmpty) {
            return Center(child: Text("لا يوجد منشورات غير مصممة"));
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
                  duration: Duration(milliseconds: 200),
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
