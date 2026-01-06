import 'package:get/get.dart';
import '../controllers/addtugas_controller.dart';

class AddtugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddtugasController>(
      () => AddtugasController(),
    );
  }
}
