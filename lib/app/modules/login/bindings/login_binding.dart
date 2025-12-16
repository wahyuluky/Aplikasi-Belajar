import 'package:get/get.dart';

// Mengimpor LoginController
// Controller ini akan digunakan pada halaman login

import '../controllers/login_controller.dart';

// LoginBinding berfungsi untuk mengatur dependency injection
// khusus untuk fitur login menggunakan GetX

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut digunakan agar LoginController
    // hanya dibuat ketika dibutuhkan pertama kali

    Get.lazyPut<LoginController>(
      () => LoginController(),
    );

    // Dengan adanya binding ini, LoginController
    // dapat diakses otomatis tanpa inisialisasi manual
  }
}
