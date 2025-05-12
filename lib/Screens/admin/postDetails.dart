import 'package:flutter/material.dart';
import 'package:MedLife/constant/appColors.dart';
import 'package:MedLife/models/postModel.dart';
import 'package:intl/intl.dart' hide TextDirection;

class PostDetailsScreen extends StatelessWidget {
  final PostModel post;

  const PostDetailsScreen({Key? key, required this.post}) : super(key: key);

  String getYesNo(int value) => value == 1 ? "نعم" : "لا";

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

      return Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'تفاصيل البوست',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: widthScreen * 0.05,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColors.primary),
      ),
      body: Padding(
        padding: EdgeInsets.all(widthScreen * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.postIdea,
              style: TextStyle(
                fontSize: widthScreen * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: heightScreen * 0.02),

            _buildDetailRow(
              Icons.group,
              "الخليّة: ${post.cellId}",
              widthScreen,
            ),
            SizedBox(height: heightScreen * 0.015),

            _buildDetailRow(
              Icons.person,
              "الكاتب: ${post.writtenBy}",
              widthScreen,
            ),
            SizedBox(height: heightScreen * 0.015),

            _buildDetailRow(
              Icons.check_circle,
              "منسق: ${getYesNo(post.isCoordinated)}",
              widthScreen,
            ),
            SizedBox(height: heightScreen * 0.01),

            _buildDetailRow(
              Icons.brush,
              "مصمم: ${getYesNo(post.isDesigned)}",
              widthScreen,
            ),
            SizedBox(height: heightScreen * 0.01),

            _buildDetailRow(
              Icons.publish,
              "منشور: ${getYesNo(post.isPublished)}",
              widthScreen,
            ),
            SizedBox(height: heightScreen * 0.015),

            _buildDetailRow(
              Icons.calendar_today,
              "تاريخ الإنشاء: ${DateFormat('yyyy/MM/dd – HH:mm').format(post.createdAt)}",
              widthScreen,
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildDetailRow(IconData icon, String text, double widthScreen) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: widthScreen * 0.06),
        SizedBox(width: widthScreen * 0.02),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: widthScreen * 0.04)),
        ),
      ],
    );
  }
}
