import 'package:get/get.dart';
import 'package:MedLife/controller/designer/UndesignedPost/UndesignedPostService.dart';
import 'package:MedLife/models/postModel.dart';

class UndesignedPostController extends GetxController {
  final posts = <PostModel>[].obs;
  final isLoading = false.obs;

  Future<void> loadPosts(int cellId) async {
    isLoading.value = true;
    final data = await UndesignedPostService().fetchUndesignedPosts(cellId);
    posts.assignAll(data);
    isLoading.value = false;
  }
}
