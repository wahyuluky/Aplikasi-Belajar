import 'package:get/get.dart';
import '../controllers/focus_timer_controller.dart';

class FocusTimerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FocusTimerController>(() => FocusTimerController());
  }
}