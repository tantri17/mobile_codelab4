import 'package:codelab4/app/modules/camera/views/camera_view.dart';
import 'package:codelab4/app/modules/home/views/home_view.dart';
import 'package:codelab4/app/modules/video/views/video_view.dart';
import 'package:get/get.dart';
import '../modules/camera/bindings/camera_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/video/bindings/video_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CAMERA;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA,
      page: () => const CameraView(),
      binding: CameraBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO,
      page: () => const VideoView(),
      binding: VideoBinding(),
    ),
  ];
}
