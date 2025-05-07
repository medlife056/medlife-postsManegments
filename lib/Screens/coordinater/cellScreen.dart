import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/Screens/coordinater/uncoordinaterPostsScreen.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/coordinate/showcellcontroller/cellController.dart';

class CoordinaterCellsScreen extends StatelessWidget {
  final controller = Get.put(CoordinaterCellsController());

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

          return ListView.separated(
            padding: EdgeInsets.all(
              isTablet ? heightScreen * 0.03 : heightScreen * 0.02,
            ),
            itemCount: controller.cells.length,
            separatorBuilder:
                (context, index) => SizedBox(
                  height: isTablet ? heightScreen * 0.03 : heightScreen * 0.02,
                ),
            itemBuilder: (context, index) {
              final cell = controller.cells[index];
              return InkWell(
                onTap: () {
                  Get.to(() => UncoordinatePostsScreen(cellId: cell.id));
                },
                child: Container(
                  padding: EdgeInsets.all(
                    isTablet ? heightScreen * 0.04 : heightScreen * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    cell.name,
                    style: TextStyle(
                      fontSize:
                          isTablet ? widthScreen * 0.05 : widthScreen * 0.04,
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
