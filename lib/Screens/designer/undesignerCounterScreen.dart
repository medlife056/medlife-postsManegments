import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/controller/designer/Undesignedcounter/UndesignedcounterController.dart';
import 'package:MedLife/controller/designer/Undesignedcounter/Undesignedcounterservice.dart';

class UndesignerCounterScreen extends StatelessWidget {
  const UndesignerCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      UndesignedcounterController(UndesignedcounterProvider()),
    );

    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Image.asset('assets/images/midlife logo.png', height: widthScreen * 0.1),
              SizedBox(width: 10),
              Text(
                "عدد المنشورات غير المصممة",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: widthScreen * 0.05,
                ),
              ),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.stats.isEmpty) {
            return Center(child: Text("لا توجد بيانات حالياً"));
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.04, vertical: heightScreen * 0.02),
            itemCount: controller.stats.length,
            itemBuilder: (context, index) {
              final item = controller.stats[index];
              return GestureDetector(
                onTap: () {
                  // يمكنك إضافة أكشن هنا إذا كان هناك حاجة
                },
                child: AnimatedScale(
                  scale: 1.0,
                  duration: Duration(milliseconds: 200),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: widthScreen * 0.04, vertical: 12),
                      leading: const Icon(Icons.groups, color: Colors.purple, size: 40),
                      title: Text(
                        item.cellName,
                        style: TextStyle(
                          fontSize: widthScreen * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        '${item.undesignedCount} منشور',
                        style: TextStyle(
                          fontSize: widthScreen * 0.04,
                          color: AppColors.primary,
                        ),
                      ),
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
