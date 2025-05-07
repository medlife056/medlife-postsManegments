import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/controller/coordinate/editPost/editPostCoordinatedController.dart';
import 'package:MedLife/controller/getVolunteers/getVolunteersController.dart';
import 'package:MedLife/models/editPostModel.dart';
import '../../../constant/appColors.dart';

class CoordinateEditPostScreen extends StatefulWidget {
  final int postId;

  const CoordinateEditPostScreen({Key? key, required this.postId})
    : super(key: key);

  @override
  State<CoordinateEditPostScreen> createState() =>
      _CoordinateEditPostScreenState();
}

class _CoordinateEditPostScreenState extends State<CoordinateEditPostScreen> {
  final Getvolunteerscontroller _getvolunteerscontroller = Get.put(
    Getvolunteerscontroller(),
  );
  final PostEditController _updateController = Get.put(PostEditController());

  bool isCoordinated = false;
  String? coordinatedBy;
  DateTime? coordinatedAt;

  @override
  void initState() {
    super.initState();
    coordinatedBy = "coordinaterBy_1"; // Modify as per the current user
    coordinatedAt = DateTime.now();
  }

  void submit() {
    final updateModel = PostUpdateModel(
      id: widget.postId,
      isCoordinated: isCoordinated ? 1 : 0,
      coordinatedBy: isCoordinated ? coordinatedBy : null,
      coordinatedAt: isCoordinated ? coordinatedAt : null,
    );
    _updateController.updatePost(updateModel);
  }

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
                "تعديل التنسيق",
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
            isTablet ? heightScreen * 0.03 : heightScreen * 0.02,
          ),
          child: Obx(() {
            if (_updateController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  title: Text(
                    "تم التنسيق؟",
                    style: TextStyle(
                      fontSize:
                          isTablet ? widthScreen * 0.05 : widthScreen * 0.04,
                    ),
                  ),
                  value: isCoordinated,
                  onChanged: (val) {
                    setState(() {
                      isCoordinated = val;
                      if (val) coordinatedAt = DateTime.now();
                    });
                  },
                ),
                if (isCoordinated) ...[
                  SizedBox(height: isTablet ? heightScreen * 0.04 : 16),
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
                      labelText: "اختر المنسق",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: isTablet ? heightScreen * 0.02 : 8,
                        horizontal: 12,
                      ),
                    ),
                    onChanged: (val) {
                      _getvolunteerscontroller.selectedVolunteerId.value = val;
                      coordinatedBy = val?.toString();
                    },
                  ),
                  SizedBox(height: isTablet ? heightScreen * 0.02 : 8),
                  Text(
                    "تاريخ التنسيق: ${coordinatedAt!.toLocal()}",
                    style: TextStyle(
                      fontSize:
                          isTablet ? widthScreen * 0.05 : widthScreen * 0.04,
                    ),
                  ),
                ],
                Spacer(),
                ElevatedButton(
                  onPressed: submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: Size.fromHeight(
                      isTablet ? heightScreen * 0.08 : 50,
                    ),
                  ),
                  child: Text(
                    "تحديث",
                    style: TextStyle(
                      fontSize:
                          isTablet ? widthScreen * 0.06 : widthScreen * 0.05,
                    ),
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
