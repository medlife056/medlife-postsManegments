import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MedLife/controller/content_Writer/editPost/editPostContentWriterController.dart';
import 'package:MedLife/controller/getVolunteers/getVolunteersController.dart';
import 'package:MedLife/models/editPostModel.dart';
import '../../../constant/appColors.dart';

class ContentWriterEditPostScreen extends StatefulWidget {
  final int postId;

  const ContentWriterEditPostScreen({Key? key, required this.postId})
    : super(key: key);

  @override
  State<ContentWriterEditPostScreen> createState() =>
      _ContentWriterEditPostScreenState();
}

class _ContentWriterEditPostScreenState
    extends State<ContentWriterEditPostScreen> {
  final Getvolunteerscontroller _getvolunteerscontroller = Get.put(
    Getvolunteerscontroller(),
  );
  final PostContentWriterEditController _updateController = Get.put(
    PostContentWriterEditController(),
  );

  bool isPublished = false;

  void submit() {
    final updateModel = PostUpdateModel(
      id: widget.postId,
      isPublished: isPublished ? 1 : 0,
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
                "تعديل المنشور",
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
                    "تم النشر؟",
                    style: TextStyle(fontSize: widthScreen * 0.04),
                  ),
                  value: isPublished,
                  onChanged: (val) {
                    setState(() {
                      isPublished = val;
                    });
                  },
                ),

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
