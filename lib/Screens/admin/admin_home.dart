import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/Screens/Dev/aboutDev.dart';
import 'package:MedLife/Screens/admin/CellUnPuplishedPostsScreen.dart';
import 'package:MedLife/Screens/admin/cellStatePostReportScreen.dart';
import 'package:MedLife/Screens/admin/createWriter.dart';
import 'package:MedLife/Screens/admin/postReportScreen.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/admin/createWriter/create_writer_binding.dart';
import 'package:MedLife/controller/admin/cellStatePostReport/cellStatePostcontroller.dart';
import 'package:MedLife/controller/admin/cellUnPuplishedPost/CellUnPuplishedPostsController.dart';
import 'package:MedLife/controller/admin/postReportController/postController.dart';
import 'package:MedLife/controller/auth_controller/logoutService.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isTablet = width > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Image.asset(
                'assets/images/midlife logo.png',
                height: height * 0.05,
              ),
              SizedBox(width: width * 0.02),
              Text(
                "الإدارة",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: width * 0.045,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: GridView.count(
            crossAxisCount: isTablet ? 3 : 2,
            crossAxisSpacing: width * 0.04,
            mainAxisSpacing: height * 0.02,
            children: [
              _AnimatedCard(
                icon: Icons.bar_chart,
                label: 'تقارير النشر',
                color: Color(0xFFFF5B7F),
                iconSize: width * 0.08,
                fontSize: width * 0.04,
                onTap: () {
                  Get.delete<PostController>();
                  Get.to(() => PostReportPage());
                },
              ),
              _AnimatedCard(
                icon: Icons.post_add,
                label: 'عدد المنشورات لكل خلية',
                color: Color(0xFF102A43),
                iconSize: width * 0.08,
                fontSize: width * 0.04,
                onTap: () {
                  Get.delete<CellPostsStatsController>();
                  Get.to(CellPostsStatsScreen());
                },
              ),
              _AnimatedCard(
                icon: Icons.unpublished,
                label: 'تقرير غير المنشورة',
                color: Color(0xFF343333),
                iconSize: width * 0.08,
                fontSize: width * 0.04,
                onTap: () {
                  Get.delete<CellUnPuplishedPostsController>();
                  Get.to(CellUnPuplishedPostsScreen());
                },
              ),
              _AnimatedCard(
                icon: Icons.person_add,
                label: 'إنشاء كاتب محتوى',
                color: Color(0xFFCC3F62),
                iconSize: width * 0.08,
                fontSize: width * 0.04,
                onTap:
                    () => Get.to(
                      () => CreateWriterScreen(),
                      binding: CreateWriterBinding(),
                    ),
              ),
              _AnimatedCard(
                icon: Icons.logout,
                label: 'تسجيل خروج',
                color: Color(0xFF575757),
                iconSize: width * 0.08,
                fontSize: width * 0.04,
                onTap: () {
                  LogoutService().logout();
                },
              ),
              _AnimatedCard(
                icon: Icons.developer_mode,
                label: 'حول المطورون',
                color: Color(0xFF1A3B5D),
                iconSize: width * 0.08,
                fontSize: width * 0.04,
                onTap: () => Get.to(() => AboutDevelopersScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  Widget _buildCard({
//   required IconData icon,
//   required String label,
//   required Color color,
//   required VoidCallback onTap,
// }) {
//   return TweenAnimationBuilder<double>(
//     tween: Tween(begin: 0, end: 1),
//     duration: Duration(milliseconds: 600),
//     curve: Curves.easeOut,
//     builder: (context, value, child) {
//       return Opacity(
//         opacity: value,
//         child: Transform.translate(
//           offset: Offset(0, (1 - value) * 20),
//           child: child,
//         ),
//       );
//     },
//     child: GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade400,
//               offset: Offset(2, 4),
//               blurRadius: 6,
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40, color: Colors.white),
//             SizedBox(height: 10),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

class _AnimatedCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final double iconSize;
  final double fontSize;

  const _AnimatedCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    required this.iconSize,
    required this.fontSize,
  });

  @override
  State<_AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<_AnimatedCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(2, 4),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: widget.iconSize, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
