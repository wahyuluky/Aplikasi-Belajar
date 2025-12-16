import 'package:get/get.dart';

import '../controllers/choose_friend_controller.dart';

class ChooseFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseFriendController>(
      () => ChooseFriendController(),
    );
  }
}
