import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/auth_service.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final usernameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  var isLoading = false.obs;

  // --------------------------
  // NOTIFIKASI BERHASIL
  // --------------------------
  void showSuccessNotification() {
    Get.dialog(
      Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            width: 250,
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF4CD964),
                width: 1.8,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ICON HIJAU
                Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CD964),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  "Registrasi berhasil",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Silahkan kembali ke halaman login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.3,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false, // tidak bisa tutup manual (auto-close)
      transitionDuration: Duration.zero,
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (Get.isDialogOpen ?? false) {
        Get.back(); // tutup popup
        Get.offAllNamed(Routes.LOGIN); // pindah halaman
      }
    });
  }

  // --------------------------
  // NOTIFIKASI GAGAL
  // --------------------------
  void showErrorNotification(String message) {
    Get.dialog(
      Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            width: 250,
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFFF6B6B),
                width: 1.8,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ICON MERAH
                Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF6B6B),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  "Registrasi gagal",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.3,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true, // <<< TAP DI LUAR = CLOSE POPUP
      transitionDuration: Duration.zero,
    );
  }

  // --------------------------
  // FUNCTION REGISTER
  // --------------------------
  void register() async {
    if (usernameC.text.isEmpty ||
        emailC.text.isEmpty ||
        passwordC.text.isEmpty) {
      showErrorNotification("Semua field wajib diisi");
      return;
    }

    if (!emailC.text.contains("@")) {
      showErrorNotification("Email tidak valid");
      return;
    }

    isLoading.value = true;

    final result = await AuthService.to.register(
      emailC.text.trim(),
      passwordC.text.trim(),
      usernameC.text.trim(),
    );

    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    if (result == null) {
      showSuccessNotification();
    } else {
      showErrorNotification(result);
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
