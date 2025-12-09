import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/auth_service.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
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
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (!emailC.text.contains("@")) {
      Get.snackbar(
        "Error",
        "Email tidak valid",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;
    final result = await AuthService.to.register(
      emailC.text.trim(),
      passwordC.text.trim(),
      usernameC.text.trim(),
    );

    await Future.delayed(const Duration(seconds: 2)); // simulasi API
    isLoading.value = false;

    if (result == null) {
      Get.snackbar(
        "Success",
        "Registrasi berhasil!",
        snackPosition: SnackPosition.TOP,
      );
      Get.offAllNamed(Routes.LOGIN); // gunakan off agar tidak bisa kembali
    } else {
      Get.snackbar("Failed", result);
    }
  }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    usernameC.dispose();
    super.onClose();
  }
}
