import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/timerfokus/controllers/timerfokus_controller.dart';

class TimerfokusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimerFokusController>(
      () => TimerFokusController(),
    );
  }
}
