import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/controller/designer/editPost/editPostDesignerController.dart';
import 'package:MedLife/controller/getVolunteers/getVolunteersController.dart';
import 'package:MedLife/models/editPostModel.dart';
import '../../../constant/appColors.dart';

class DesignerEditPostScreen extends StatefulWidget {
  final int postId;

  const DesignerEditPostScreen({Key? key, required this.postId})
    : super(key: key);

  @override
  State<DesignerEditPostScreen> createState() => _DesignerEditPostScreenState();
}

class _DesignerEditPostScreenState extends State<DesignerEditPostScreen> {
  final Getvolunteerscontroller _getvolunteerscontroller = Get.put(
    Getvolunteerscontroller(),
  );
  final DesignerPostEditController _updateController = Get.put(DesignerPostEditController());

  bool isDesigned = false;
  String? designedBy;
  DateTime? designedAt;

  @override
  void initState() {
    super.initState();
    designedBy = "designer_1"; // تغيير حسب المستخدم الحالي
    designedAt = DateTime.now();
  }

  void submit() {
    final updateModel = PostUpdateModel(
      id: widget.postId,
      isDesigned: isDesigned ? 1 : 0,
      designedBy: isDesigned ? designedBy : null,
      designedAt: isDesigned ? designedAt : null,
    );
    _updateController.updatePost(updateModel);
  }

  @override
  Widget build(BuildContext context) {
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
              Image.asset(
                'assets/images/midlife logo.png',
                height: widthScreen * 0.1,
              ),
              SizedBox(width: 10),
              Text(
                "تعديل التصميم",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: widthScreen * 0.05,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(widthScreen * 0.05),
          child: Obx(() {
            if (_updateController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  title: Text(
                    "تم التصميم؟",
                    style: TextStyle(fontSize: widthScreen * 0.04),
                  ),
                  value: isDesigned,
                  onChanged: (val) {
                    setState(() {
                      isDesigned = val;
                      if (val) designedAt = DateTime.now();
                    });
                  },
                ),
                if (isDesigned) ...[
                  SizedBox(height: heightScreen * 0.02),
                  DropdownButtonFormField<int>(
                    value: _getvolunteerscontroller.selectedVolunteerId.value,
                    items:
                        _getvolunteerscontroller.volunteers.map((volunteer) {
                          return DropdownMenuItem<int>(
                            value: volunteer.id,
                            child: Text(volunteer.name),
                          );
                        }).toList(),
                    decoration: InputDecoration(
                      labelText: "اختر المصمم",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      _getvolunteerscontroller.selectedVolunteerId.value = val;
                      designedBy = val?.toString();
                    },
                  ),
                  SizedBox(height: heightScreen * 0.02),
                  Text(
                    "تاريخ التصميم: ${designedAt!.toLocal()}",
                    style: TextStyle(fontSize: widthScreen * 0.04),
                  ),
                ],
                Spacer(),
                ElevatedButton(
                  onPressed: submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: Size.fromHeight(heightScreen * 0.07),
                  ),
                  child: Text(
                    "تحديث",
                    style: TextStyle(fontSize: widthScreen * 0.045),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
