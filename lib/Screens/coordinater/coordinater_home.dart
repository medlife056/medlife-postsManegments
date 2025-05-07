import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/Screens/Dev/aboutDev.dart';
import 'package:MedLife/Screens/coordinater/cellScreen.dart';
import 'package:MedLife/Screens/coordinater/uncoordinaterCounterScreen.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/auth_controller/logoutService.dart';
import 'package:MedLife/controller/coordinate/UnCoordinatedcounter/UnCoordinatedcounterController.dart';
import 'package:MedLife/controller/coordinate/showcellcontroller/cellController.dart';

class CoordinaterHomeScreen extends StatelessWidget {
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
                "المنسق",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: isTablet ? widthScreen * 0.06 : widthScreen * 0.05,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(isTablet ? heightScreen * 0.03 : heightScreen * 0.02),
          child: GridView.count(
            crossAxisCount: isTablet ? 3 : 2,
            crossAxisSpacing: isTablet ? widthScreen * 0.05 : 16,
            mainAxisSpacing: isTablet ? heightScreen * 0.04 : 16,
            children: [
              _AnimatedCard(
                icon: Icons.design_services,
                label: 'غير منسقة لكل خلية',
                color: AppColors.primary,
                onTap: () {
                  Get.delete<UnCoordinatercounterController>();
                  Get.to(() => UncoordinaterCounterscreen());
                },
              ),
              _AnimatedCard(
                icon: Icons.history,
                label: 'تنسيقاتي السابقة',
                color: Colors.indigo.shade200,
                onTap: () {
                  Get.delete<CoordinaterCellsController>();
                  Get.to(() => CoordinaterCellsScreen());
                },
              ),
              _AnimatedCard(
                icon: Icons.logout,
                label: 'تسجيل الخروج',
                color: Colors.grey.shade400,
                onTap: () {
                  LogoutService().logout();
                },
                
              ),
               _AnimatedCard(
                icon: Icons.developer_mode,
                label: 'حول المطورون',
                color: Colors.grey.shade400,
                onTap: () {
                  AboutDevelopersScreen();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AnimatedCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
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
              Icon(widget.icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 16,
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
