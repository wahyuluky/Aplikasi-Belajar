import 'package:get/get.dart';

import '../controllers/addschedule_controller.dart';

class AddscheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddscheduleController>(
      () => AddscheduleController(),
    );
  }
}
