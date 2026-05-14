import 'package:get/get.dart';
import 'package:MedLife/controller/admin/postReportController/postService.dart';
import 'package:MedLife/models/postModel.dart';

class PostController extends GetxController {

  var isLoading = true.obs;

  var postList = <PostModel>[].obs;

  var errorMessage = RxnString();

  final PostProvider _postProvider = PostProvider();

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  @override
  void onReady() {
    super.onReady();
    fetchPosts();
  }

  @override
  void onClose() {
    postList.clear();
    super.onClose();
  }

  Future<void> fetchPosts() async {

    try {

      isLoading(true);

      final posts =
          await _postProvider.fetchPosts();

      postList.assignAll(posts);

      errorMessage.value = null;

    } catch (e) {

      errorMessage.value = e.toString();

    } finally {

      isLoading(false);
    }
  }
}