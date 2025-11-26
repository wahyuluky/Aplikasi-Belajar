import 'package:flutter_application_1/app/modules/choose_friend/controllers/choose_friend_controller.dart';
import 'package:get/get.dart';

class ChooseFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChooseFriendController());
  }
}

