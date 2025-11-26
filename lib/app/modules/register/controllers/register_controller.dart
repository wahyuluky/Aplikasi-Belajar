import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final usernameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  var isLoading = false.obs;

  void register() async {
    if (usernameC.text.isEmpty ||
        emailC.text.isEmpty ||
        passwordC.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Semua field harus diisi",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (!emailC.text.contains("@")) {
      Get.snackbar(
        "Error",
        "Email tidak valid",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // simulasi API
    isLoading.value = false;

    Get.snackbar(
      "Success",
      "Registrasi berhasil!",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
