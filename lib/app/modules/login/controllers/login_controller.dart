import 'package:flutter_application_1/app/data/auth_service.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

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

  // ============================================================
  // POPUP FIX — SAMA PERSIS DENGAN PUNYA REGISTRASI
  // ============================================================
  void showPopup({
    required String title,
    required String message,
    required Color color,
    required IconData icon,
    bool autoClose = false,
  }) {
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
                color: color,
                width: 1.8,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // BULATAN ICON—SOLID WARNA
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 14),

                // JUDUL
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 6),

                // PESAN
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


      // Jika autoClose false → dialog bisa ditutup manual
      // Jika autoClose true → dialog tertutup otomatis
      barrierDismissible:
          !autoClose, // gagal → bisa tap luar, sukses → auto close
      transitionDuration: Duration.zero, // tidak slowmo
    );

    // Menutup popup otomatis jika login berhasil
    if (autoClose) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      });
    }
  }

  // ============================================================
  // FUNGSI LOGIN
  // Menangani validasi input, proses autentikasi,
  // serta navigasi ke halaman utama
  // ============================================================
  void login() async {
    // Validasi input kosong
    if (emailC.text.isEmpty || passwordC.text.isEmpty) {
      showPopup(
        title: "Login gagal",
        message: "Username dan password wajib diisi",
        color: const Color.fromARGB(255, 255, 107, 97),
        icon: Icons.close,
      );
      return;
    }

    // Validasi format email sederhana
    if (!emailC.text.contains("@")) {
      showPopup(
        title: "Login gagal",
        message: "Email tidak valid",
        color: const Color.fromARGB(255, 255, 107, 97),
        icon: Icons.close,
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

    // Delay kecil agar transisi loading lebih halus
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;

    // ======================
    // LOGIN BERHASIL
    // ======================
    if (result == null) {
      showPopup(
        title: "Login berhasil",
        message: "Selamat datang di aplikasi manajemen tugas",
        color: Colors.green,
        icon: Icons.check,
        autoClose: true,
      );

      // Navigasi ke halaman HOME
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.offAllNamed(Routes.HOME);
      });

      return;
    }

    // ======================
    // LOGIN GAGAL
    // ======================
    showPopup(
      title: "Login gagal",
      message: result,
      color: const Color.fromARGB(255, 255, 107, 96),
      icon: Icons.close,
    );
  }

// Membersihkan controller ketika halaman ditutup
  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}
