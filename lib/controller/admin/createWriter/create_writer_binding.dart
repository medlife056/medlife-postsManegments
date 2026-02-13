import 'package:get/get.dart';
import 'package:MedLife/controller/admin/createWriter/createWriterController.dart';

class CreateWriterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateWriterController());
  }
}