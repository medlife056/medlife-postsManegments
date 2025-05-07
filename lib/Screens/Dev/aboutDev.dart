import 'package:flutter/material.dart';
import 'package:MedLife/constant/appColors.dart';

class AboutDevelopersScreen extends StatelessWidget {
  const AboutDevelopersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'حول المطورين',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: isTablet ? 28 : 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildDeveloperCard(
                name: 'قصي الحشيش',
                role: 'Mobile Application Developer | Flutter',
                email: 'qusayhash@gmail.com',
                imagePath: 'assets/images/qusai.png',
                isTablet: isTablet,
              ),
              _buildDeveloperCard(
                name: 'عمر عمرين',
                role: 'BackEnd Developer | Laravel',
                email: 'omar.omarain@hotmail.com',
                imagePath: 'assets/images/omar.jpg',
                isTablet: isTablet,
              ),
                _buildDeveloperCard(
                name: 'معاذ عباس',
                role: 'مطور تطبيقات Flutter',
                email: 'mouaz.abbas.2000@gmail.com',
                imagePath: 'assets/images/moaaz.jpg',
                isTablet: isTablet,
              ),
                _buildDeveloperCard(
                name: 'خوله مقداد محمد',
                role: 'Project Manager',
                email: 'Khoula77123@gmail.com',
                imagePath: 'assets/images/khaola.jpg',
                isTablet: isTablet,
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'هذا التطبيق تم تطويره بحب 💙 لخدمة العمل التطوعي',
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeveloperCard({
    required String name,
    required String role,
    required String email,
    required String imagePath,
    required bool isTablet,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imagePath)
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: isTablet ? 20 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(role, style: TextStyle(fontSize: isTablet ? 18 : 16)),
            const SizedBox(height: 4),
            Text(
              email,
              style: TextStyle(
                fontSize: isTablet ? 16 : 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
