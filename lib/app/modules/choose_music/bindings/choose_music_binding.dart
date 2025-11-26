import 'package:get/get.dart';

import '../controllers/choose_music_controller.dart';

class ChooseMusicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseMusicController>(
      () => ChooseMusicController(),
    );
  }
}
