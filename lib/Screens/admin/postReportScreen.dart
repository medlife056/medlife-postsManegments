import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/Screens/admin/postDetails.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/admin/postReportController/postController.dart';

class PostReportPage extends StatelessWidget {
  final PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "تقارير المنشورات",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: widthScreen * 0.045, // حجم خط متغير حسب العرض
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: controller.postList.length,
            itemBuilder: (context, index) {
              final post = controller.postList[index];
              return InkWell(
                onTap: () {
                  Get.to(() => PostDetailsScreen(post: post));
                },
                child: Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: widthScreen * 0.03,
                    vertical: heightScreen * 0.005,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(widthScreen * 0.02),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.postIdea,
                                style: TextStyle(
                                  fontSize: widthScreen * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: heightScreen * 0.005),
                              Text(
                                "بواسطة: ${post.writtenBy} | خلية: ${post.cellId}",
                                style: TextStyle(fontSize: widthScreen * 0.035),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: widthScreen * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "تم النشر: ${post.isPublished == 1 ? "نعم" : "لا"}",
                              style: TextStyle(fontSize: widthScreen * 0.035),
                            ),
                            Text(
                              "تم التصميم: ${post.isDesigned == 1 ? "نعم" : "لا"}",
                              style: TextStyle(fontSize: widthScreen * 0.035),
                            ),
                          ],
                        ),
                      ],
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
