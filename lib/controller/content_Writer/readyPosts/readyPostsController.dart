import 'package:get/get.dart';
import 'package:MedLife/controller/content_Writer/readyPosts/readyPostsService.dart';
import 'package:MedLife/models/readyPostsModel.dart';

class ReadyPostController extends GetxController {
  var isLoading = true.obs;

  var posts = <ReadyPostModel>[].obs;

  var errorMessage = ''.obs;

  final ReadyPostsService _service = ReadyPostsService();

  @override
  void onReady() {
    super.onReady();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading(true);

      errorMessage.value = '';

      posts.value = await _service.fetchReadyPosts();

      if (posts.isEmpty) {
        errorMessage.value = "لا يوجد منشورات جاهزة";
      }
    } catch (e) {
      errorMessage.value = "فشل في تحميل المنشورات";
    } finally {
      isLoading(false);
    }
  }
}