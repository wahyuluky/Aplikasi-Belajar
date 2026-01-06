import 'package:get/get.dart';
import 'package:flutter_application_1/app/data/auth_service.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

class SplashController extends GetxController {
@override
  void onReady() async {
    await Future.delayed(const Duration(seconds: 1));

    if (AuthService.to.currentUser != null) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
