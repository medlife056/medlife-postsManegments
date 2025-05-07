import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/Screens/coordinater/editPostcoordinaterScreen.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/coordinate/UnCoordinatedPost/UnCoordinatedPostController.dart';

class UncoordinatePostsScreen extends StatelessWidget {
  final int cellId;
  final controller = Get.put(UncoordinatePostController());

  UncoordinatePostsScreen({required this.cellId}) {
    controller.loadPosts(cellId);
  }

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
              SizedBox(width: 10),
              Text(
                "المنشورات الغير منسقة لكل خلية",
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
            return Center(child: CircularProgressIndicator());
          }
          if (controller.posts.isEmpty) {
            return Center(
              child: Text(
                "لا يوجد منشورات غير منسقة",
                style: TextStyle(
                  fontSize: isTablet ? widthScreen * 0.06 : widthScreen * 0.05,
                ),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? widthScreen * 0.05 : 16,
              vertical: isTablet ? heightScreen * 0.03 : 8,
            ),
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return Card(
                margin: EdgeInsets.symmetric(
                  horizontal: isTablet ? widthScreen * 0.05 : 16,
                  vertical: isTablet ? heightScreen * 0.03 : 8,
                ),
                child: ListTile(
                  title: Text(
                    post.postIdea,
                    style: TextStyle(
                      fontSize:
                          isTablet ? widthScreen * 0.05 : widthScreen * 0.04,
                    ),
                  ),
                  subtitle: Text(
                    'كتبه: ${post.writtenBy}',
                    style: TextStyle(
                      fontSize:
                          isTablet ? widthScreen * 0.045 : widthScreen * 0.035,
                    ),
                  ),
                  trailing: Icon(
                    Icons.edit,
                    color: AppColors.primary,
                    size: isTablet ? 30 : 24,
                  ),
                  onTap: () {
                    Get.to(() => CoordinateEditPostScreen(postId: post.id));
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
