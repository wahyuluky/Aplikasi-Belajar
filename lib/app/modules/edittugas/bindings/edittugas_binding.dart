import 'package:get/get.dart';

import '../controllers/edittugas_controller.dart';

class EdittugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EdittugasController>(
      () => EdittugasController(),
    );
  }
}
