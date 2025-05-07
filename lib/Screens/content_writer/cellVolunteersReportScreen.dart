import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/content_Writer/cellVolunteerReport/CellVolunteerReportcontroller.dart';

class CellVolunteersReportScreen extends StatelessWidget {
  final controller = Get.put(CellVolunteersReportController());

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
                "تقرير متطوعين الخلية",
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

          if (controller.volunteers.isEmpty) {
            return const Center(child: Text('لا يوجد بيانات حالياً'));
          }

          return ListView.builder(
            itemCount: controller.volunteers.length,
            itemBuilder: (context, index) {
              final v = controller.volunteers[index];
              return Card(
                margin: EdgeInsets.symmetric(
                  vertical: heightScreen * 0.02,
                  horizontal: widthScreen * 0.05,
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: widthScreen * 0.04,
                    vertical: heightScreen * 0.01,
                  ),
                  title: Text(
                    v.name,
                    style: TextStyle(fontSize: widthScreen * 0.045),
                  ),
                  subtitle: Text(
                    '${v.position} | ${v.status}',
                    style: TextStyle(fontSize: widthScreen * 0.04),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.post_add,
                        size: widthScreen * 0.07,
                        color: AppColors.primary,
                      ),
                      Text(
                        '${v.publishedPosts} منشور',
                        style: TextStyle(
                          fontSize: widthScreen * 0.04,
                          fontWeight: FontWeight.bold,
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
