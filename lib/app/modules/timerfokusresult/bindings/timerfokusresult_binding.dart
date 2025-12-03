import 'package:get/get.dart';

import '../controllers/timerfokusresult_controller.dart';

class TimerfokusresultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimerfokusresultController>(
      () => TimerfokusresultController(),
    );
  }
}
