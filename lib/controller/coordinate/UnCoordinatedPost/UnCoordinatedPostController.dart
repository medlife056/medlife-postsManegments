import 'package:get/get.dart';
import 'package:MedLife/controller/coordinate/UnCoordinatedPost/UnCoordinatedPostService.dart';
import 'package:MedLife/models/postModel.dart';

class UncoordinatePostController extends GetxController {
  final posts = <PostModel>[].obs;
  final isLoading = false.obs;

  Future<void> loadPosts(int cellId) async {
    isLoading.value = true;
    final data = await UncoordinatePostService().fetchUncoordinatePosts(cellId);
    posts.assignAll(data);
    isLoading.value = false;
  }
}
