import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/auth_service.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

// LoginController bertugas mengatur logika login
// termasuk validasi input, pemanggilan service,
// serta navigasi setelah login

class LoginController extends GetxController {
  // Controller untuk input email
  final emailC = TextEditingController();
  // Controller untuk input password
  final passwordC = TextEditingController();

  
  // State loading untuk indikator proses login
  var isLoading = false.obs;

  void login() async {
    // Validasi input kosong
    if (emailC.text.isEmpty || passwordC.text.isEmpty) {
      Get.snackbar(
        "Warning!",
        "Email dan Password harus diisi",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Validasi format email sederhana
    if (!emailC.text.contains("@")) {
      Get.snackbar(
        "Error",
        "Email tidak valid",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Menampilkan loading saat proses login
    isLoading.value = true;

    // Memanggil AuthService untuk proses login
    final result = await AuthService.to.login(
      emailC.text.trim(),
      passwordC.text.trim(),
    );

    // await Future.delayed(const Duration(seconds: 1)); // simulasi API

    isLoading.value = false;

    if (result == null) {
      Get.snackbar(
        "Success",
        "Login berhasil!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Get.offAllNamed(Routes.HOME); // tidak bisa kembali ke login
    } else {
      Get.snackbar(
        "Login Failed", 
        result,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        );
    }
    
  }

// Membersihkan controller ketika halaman ditutup
  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}
