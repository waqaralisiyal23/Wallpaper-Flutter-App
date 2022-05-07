import 'package:get/instance_manager.dart';
import 'package:wallpaperapp/controllers/wallpaper_controller.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WallpaperController());
  }
}
