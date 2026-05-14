import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/Screens/designer/undesignedPostsScreen.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/designer/showcellcontroller/cellController.dart';

class DesignerCellsScreen extends StatelessWidget {
  const DesignerCellsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DesignerCellsController()); // ✅ inside build

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
              const SizedBox(width: 10),
              Text(
                "الخلايا",
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

          // ✅ error state with retry button
          if (controller.errorMessage.value.isNotEmpty &&
              controller.cells.isEmpty) {
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
                    onPressed: () => controller.loadCells(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          if (controller.cells.isEmpty) {
            return const Center(child: Text('لا توجد خلايا حالياً'));
          }

          return ListView.separated(
            padding: EdgeInsets.all(isTablet ? widthScreen * 0.05 : 16),
            itemCount: controller.cells.length,
            separatorBuilder:
                (context, index) =>
                    SizedBox(height: isTablet ? heightScreen * 0.02 : 10),
            itemBuilder: (context, index) {
              final cell = controller.cells[index];

              return InkWell(
                onTap: () {
                  Get.to(() => UndesignedPostsScreen(cellId: cell.id));
                },
                child: Container(
                  padding: EdgeInsets.all(isTablet ? widthScreen * 0.05 : 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    cell.name,
                    style: TextStyle(
                      fontSize: isTablet ? widthScreen * 0.06 : 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
