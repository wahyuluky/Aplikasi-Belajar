import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EdittugasController extends GetxController {
  //TODO: Implement EdittugasController

  // Controller untuk input
  TextEditingController tugasC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();
  TextEditingController tanggalC = TextEditingController();

  RxBool isCompleted = false.obs;

  void pilihTanggal(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      tanggalC.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  void simpan() {
    // Logika simpan data
    if (tugasC.text.isEmpty || tanggalC.text.isEmpty) {
      Get.snackbar("Error", "Tugas dan tanggal wajib diisi");
      return;
    }

    // TODO: Simpan ke database / API
    Get.snackbar("Sukses", "To-Do berhasil disimpan");
    Get.back();
  }
}
