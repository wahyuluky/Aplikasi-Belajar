import 'package:flutter_application_1/app/modules/addschedule/controllers/addschedule_controller.dart';
import 'package:get/get.dart';


class AddscheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddscheduleController>(
      () => AddscheduleController(),
    );
  }
}
