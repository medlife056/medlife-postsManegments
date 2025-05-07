import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/content_Writer/cellBankReport/cellBankReportController.dart';

class CellBankScreen extends StatelessWidget {
  const CellBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final isTablet = widthScreen > 600;

    final controller = Get.put(
      CellBankController(),
    ); // ✅ تأكد من إنشاء وربط الكنترولر

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
                "تقرير بنك الخلية",
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
          } else if (controller.stats.value == null) {
            return Center(child: Text(controller.errorMessage.value));
          }

          final stats = controller.stats.value!;
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: widthScreen * 0.05,
              vertical: 16,
            ),
            children: [
              _buildStatCard(
                'الأفكار المنشورة',
                stats.publishedIdeas,
                widthScreen,
              ),
              _buildStatCard(
                'جاهزة ولم تُنشر',
                stats.readyButNotPublished,
                widthScreen,
              ),
              _buildStatCard(
                'بانتظار التنسيق',
                stats.pendingCoordination,
                widthScreen,
              ),
              _buildStatCard(
                'بانتظار التصميم',
                stats.pendingDesign,
                widthScreen,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStatCard(String title, int value, double widthScreen) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: widthScreen * 0.045,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Text(
          value.toString(),
          style: TextStyle(
            fontSize: widthScreen * 0.05,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
