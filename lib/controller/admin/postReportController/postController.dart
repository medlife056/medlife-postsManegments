import 'package:get/get.dart';
import 'package:MedLife/controller/admin/postReportController/postService.dart';
import 'package:MedLife/models/postModel.dart';

class PostController extends GetxController {
  var isLoading = true.obs;
  var postList = <PostModel>[].obs;

  final PostProvider _postProvider = PostProvider();

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  @override
  void onReady() {
    super.onReady();
    fetchPosts(); // كل مرة ترجع للواجهة رح تنعاد
  }

  @override
  void onClose() {
    super.onClose();
    postList.clear(); 
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      var posts = await _postProvider.fetchPosts();
      postList.assignAll(posts);
    } finally {
      isLoading(false);
    }
  }
}
