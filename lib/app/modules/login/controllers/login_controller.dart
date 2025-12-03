import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();

  var isLoading = false.obs;

  void login() async {
    if (usernameC.text.isEmpty || passwordC.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Username dan Password harus diisi",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }



    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // simulasi API

    isLoading.value = false;

    // Login berhasil (dummy)
    Get.snackbar(
      "Success",
      "Login berhasil!",
      snackPosition: SnackPosition.BOTTOM,
    );

    Get.offAllNamed(Routes.HOME);
  }
}
