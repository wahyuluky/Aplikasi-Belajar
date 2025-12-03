import 'package:get/get.dart';

import '../controllers/focus_rest_controller.dart';

class FocusRestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FocusRestController>(
      () => FocusRestController(),
    );
  }
}
