import 'package:get/get.dart';

import '../controllers/profile_teman_controller.dart';

class ProfileTemanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileTemanController>(
      () => ProfileTemanController(),
    );
  }
}
