import 'package:get/get.dart';
import '../../tugas/controllers/tugas_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // WAJIB: controller dependency dulu
    Get.put<TugasController>(TugasController(), permanent: true);

    // Baru dashboard
    Get.put<DashboardController>(DashboardController());
  }
}

