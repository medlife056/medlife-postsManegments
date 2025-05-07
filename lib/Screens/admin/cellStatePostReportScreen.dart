import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/admin/cellStatePostReport/cellStatePostService.dart';
import 'package:MedLife/controller/admin/cellStatePostReport/cellStatePostcontroller.dart';

class CellPostsStatsScreen extends StatelessWidget {
  final controller = Get.put(CellPostsStatsController(CellPostsProvider()));

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'عدد المنشورات لكل خلية',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: widthScreen * 0.045,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.stats.isEmpty) {
            return const Center(child: Text("لا يوجد بيانات حالياً"));
          }

          return ListView.builder(
            itemCount: controller.stats.length,
            itemBuilder: (context, index) {
              final stat = controller.stats[index];
              return Card(
                margin: EdgeInsets.symmetric(
                  horizontal: widthScreen * 0.04,
                  vertical: heightScreen * 0.01,
                ),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.groups,
                    color: AppColors.primary,
                    size: widthScreen * 0.07,
                  ),
                  title: Text(
                    stat.cellName,
                    style: TextStyle(fontSize: widthScreen * 0.045),
                  ),
                  trailing: Text(
                    "${stat.publishedPosts} منشور",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widthScreen * 0.045,
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
