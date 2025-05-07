import 'package:get/get.dart';
import 'package:MedLife/controller/content_Writer/readyPosts/readyPostsService.dart';
import 'package:MedLife/models/readyPostsModel.dart';

class ReadyPostController extends GetxController {
  var isLoading = true.obs;
  var posts = <ReadyPostModel>[].obs;

  final ReadyPostsService _service = ReadyPostsService();

  @override
  void onReady() {
    super.onReady();
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      posts.value = await _service.fetchReadyPosts();
    } catch (e) {
      Get.snackbar('خطأ', '$e');
    } finally {
      isLoading(false);
    }
  }
}
