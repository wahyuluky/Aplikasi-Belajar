import 'package:flutter_application_1/app/modules/timerfokus/controllers/timerfokus_controller.dart';
import 'package:get/get.dart';

class TimerfokusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimerFokusController>(
      () => TimerFokusController(),
    );
  }
}
