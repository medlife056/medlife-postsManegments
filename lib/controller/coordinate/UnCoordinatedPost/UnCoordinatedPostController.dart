import 'package:get/get.dart';
import 'package:MedLife/controller/coordinate/UnCoordinatedPost/UnCoordinatedPostService.dart';
import 'package:MedLife/models/postModel.dart';

class UncoordinatePostController extends GetxController {
  final posts = <PostModel>[].obs;
  final isLoading = false.obs;
  var errorMessage = ''.obs; // ✅ added for UI error display

  Future<void> loadPosts(int cellId) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final data = await UncoordinatePostService().fetchUncoordinatePosts(
        cellId,
      );
      posts.assignAll(data);

      if (data.isEmpty) {
        errorMessage.value = 'لا يوجد منشورات غير منسقة';
      }
    } catch (e) {
      errorMessage.value = 'فشل في جلب البيانات';
    } finally {
      isLoading.value = false;
    }
  }
}
