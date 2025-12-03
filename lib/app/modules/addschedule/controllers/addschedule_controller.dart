import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddscheduleController extends GetxController {
  final subjectC = TextEditingController();
  final dateC = TextEditingController();

  // Simpan data
  void saveSchedule() {
    if (subjectC.text.isEmpty || dateC.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Semua field harus diisi!",
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.red,
      );
      return;
    }

    Get.back(result: {
      "subject": subjectC.text,
      "date": dateC.text,
    });

    Get.snackbar(
      "Berhasil",
      "Jadwal berhasil ditambahkan",
      backgroundColor: Colors.green.withOpacity(0.3),
      colorText: Colors.green.shade800,
    );
  }
}


