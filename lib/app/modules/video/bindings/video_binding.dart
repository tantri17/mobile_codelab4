// ignore: depend_on_referenced_packages
import 'package:codelab4/app/modules/video/controllers/video_controller.dart';
import 'package:get/get.dart';

class VideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoController>(() => VideoController());
  }
}
