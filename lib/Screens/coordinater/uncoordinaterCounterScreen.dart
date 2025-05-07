import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/coordinate/UnCoordinatedcounter/UnCoordinatedcounterController.dart';
import 'package:MedLife/controller/coordinate/UnCoordinatedcounter/UnCoordinatedcounterservice.dart';

class UncoordinaterCounterscreen extends StatelessWidget {
  const UncoordinaterCounterscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      UnCoordinatercounterController(UncoordinatecounterProvider()),
    );

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
                "عدد المنشورات الغير منسقة لكل خلية",
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

          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? widthScreen * 0.05 : 12,
              vertical: isTablet ? heightScreen * 0.03 : 8,
            ),
            itemCount: controller.stats.length,
            itemBuilder: (context, index) {
              final item = controller.stats[index];
              return Card(
                margin: EdgeInsets.symmetric(
                  horizontal: isTablet ? widthScreen * 0.05 : 12,
                  vertical: isTablet ? heightScreen * 0.03 : 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                child: ListTile(
                  leading: Icon(Icons.groups, color: Colors.purple),
                  title: Text(
                    item.cellName,
                    style: TextStyle(
                      fontSize:
                          isTablet ? widthScreen * 0.05 : widthScreen * 0.04,
                    ),
                  ),
                  trailing: Text(
                    '${item.uncoordinateCount} Post',
                    style: TextStyle(
                      fontSize:
                          isTablet ? widthScreen * 0.05 : widthScreen * 0.04,
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
