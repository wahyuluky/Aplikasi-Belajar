import 'package:flutter_application_1/app/data/auth_service.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  var isLoading = false.obs;

  void login() async {
    if (emailC.text.isEmpty || passwordC.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Email dan Password harus diisi",
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

    final result = await AuthService.to.login(
      emailC.text.trim(),
      passwordC.text.trim(),
    );

    await Future.delayed(const Duration(seconds: 2)); // simulasi API

    isLoading.value = false;

    if (result == null) {
      Get.snackbar(
        "Success",
        "Login berhasil!",
        snackPosition: SnackPosition.TOP,
      );
      Get.offAllNamed(Routes.HOME); // tidak bisa kembali ke login
    } else {
      Get.snackbar("Login Failed", result);
    }
    
  }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}
