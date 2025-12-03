import 'package:get/get.dart';

import '../controllers/editschedule_controller.dart';

class EditscheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditscheduleController>(
      () => EditscheduleController(),
    );
  }
}
