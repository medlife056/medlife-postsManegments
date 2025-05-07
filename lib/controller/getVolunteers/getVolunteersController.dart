import 'package:get/get.dart';
import 'package:MedLife/controller/getVolunteers/getVolunteersService.dart';
import 'package:MedLife/models/volunteer.dart';

class Getvolunteerscontroller extends GetxController {
  final Getvolunteersservice _postService = Getvolunteersservice();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var volunteers = <Volunteer>[].obs;
  var selectedVolunteerId = Rxn<int>();

  @override
  void onInit() {
    fetchVolunteers();
    super.onInit();
  }

  Future<void> fetchVolunteers() async {
    try {
      isLoading.value = true;
      final fetchedVolunteers = await _postService.getVolunteers();
      volunteers.assignAll(fetchedVolunteers);
    } catch (e) {
      errorMessage.value = "فشل في تحميل المتطوعين";
    } finally {
      isLoading.value = false;
    }
  }
}
