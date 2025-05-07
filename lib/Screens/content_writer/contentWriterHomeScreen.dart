import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/Screens/Dev/aboutDev.dart';
import 'package:MedLife/Screens/content_writer/addPostScreen.dart';
import 'package:MedLife/Screens/content_writer/cellBankReportScreen.dart';
import 'package:MedLife/Screens/content_writer/cellVolunteersReportScreen.dart';
import 'package:MedLife/Screens/content_writer/readyPostsScreen.dart';
import 'package:MedLife/controller/auth_controller/logoutService.dart';
import 'package:MedLife/controller/content_Writer/addPost/addPostController.dart';
import 'package:MedLife/controller/content_Writer/cellBankReport/cellBankReportController.dart';
import 'package:MedLife/controller/content_Writer/cellVolunteerReport/CellVolunteerReportcontroller.dart';
import 'package:MedLife/controller/content_Writer/readyPosts/readyPostsController.dart';
import '../../../constant/appColors.dart';

class ContentWriterHomeScreen extends StatelessWidget {
  const ContentWriterHomeScreen({super.key});

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
                "كاتب المحتوى",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: isTablet ? widthScreen * 0.06 : widthScreen * 0.05,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(
            isTablet ? heightScreen * 0.02 : heightScreen * 0.01,
          ),
          child: GridView.count(
            crossAxisCount: isTablet ? 3 : 2,
            crossAxisSpacing:
                isTablet ? widthScreen * 0.05 : widthScreen * 0.04,
            mainAxisSpacing:
                isTablet ? heightScreen * 0.05 : heightScreen * 0.03,
            children: [
              _HomeCard(
                title: "إنشاء بوست",
                icon: Icons.post_add,
                onTap: () {
                  Get.delete<AddPostController>();
                  Get.to(AddPostScreen());
                },
                backgroundColor: Color(0xFFFFE5EC),
                iconColor: Color(0xFFFF5B7F),
              ),
              _HomeCard(
                title: "تقرير بنك الخلية",
                icon: Icons.bar_chart,
                onTap: () {
                  Get.delete<CellBankController>();
                  Get.to(CellBankScreen());
                },
                backgroundColor: Color(0xFFD9E8F4),
                iconColor: Color(0xFF102A43),
              ),
              _HomeCard(
                title: "منشورات جاهزة للنشر",
                icon: Icons.publish,
                onTap: () {
                  Get.delete<ReadyPostController>();
                  Get.to(ReadyPostScreen());
                },
                backgroundColor: Color(0xFFF4E8E8),
                iconColor: Color(0xFF343333),
              ),
              _HomeCard(
                title: "تقرير أفراد الخلية",
                icon: Icons.people,
                onTap: () {
                  Get.delete<CellVolunteersReportController>();
                  Get.to(CellVolunteersReportScreen());
                },
                backgroundColor: Color(0xFFE7F5F0),
                iconColor: Color(0xFF2A9D8F),
              ),
              _HomeCard(
                title: "تسجيل خروج",
                icon: Icons.logout,
                onTap: () {
                  LogoutService().logout();
                },
                backgroundColor: Color(0xFFECECEC),
                iconColor: Color(0xFF757575),
              ),
              _HomeCard(
                title: "حول المطورون",
                icon: Icons.developer_mode,
                onTap: () {
                  Get.to(AboutDevelopersScreen());
                },
                backgroundColor: Color(0xFFE5F0FA),
                iconColor: Color(0xFF1A3B5D),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;

  const _HomeCard({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final isTablet = widthScreen > 600;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: EdgeInsets.all(
            isTablet ? heightScreen * 0.03 : heightScreen * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: isTablet ? widthScreen * 0.12 : widthScreen * 0.08,
                color: iconColor,
              ),
              SizedBox(
                height: isTablet ? heightScreen * 0.03 : heightScreen * 0.02,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isTablet ? widthScreen * 0.05 : widthScreen * 0.04,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
