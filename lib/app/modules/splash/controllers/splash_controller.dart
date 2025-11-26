import 'package:get/get.dart';

class SplashController extends GetxController {
 @override
  void onInit() {
    super.onInit();
    
    // Delay 2 detik lalu pindah ke halaman berikutnya
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed('/login');   // ubah route sesuai kebutuhan
    });
  }
}
