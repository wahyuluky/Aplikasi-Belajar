import 'package:get/get.dart';

import '../controllers/grupbelajar_controller.dart';

class GrupbelajarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GrupbelajarController>(
      () => GrupbelajarController(),
    );
  }
}
