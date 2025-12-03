import 'package:get/get.dart';
import '../controllers/koleksi_musik_controller.dart';

class KoleksiMusikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KoleksiMusikController>(() => KoleksiMusikController());
  }
}
