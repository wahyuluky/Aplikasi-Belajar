import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'tugas_model.dart';

class TugasController extends GetxController {
  var listTugas = <TugasModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Dummy data sesuai UI
    listTugas.addAll([
      TugasModel(
        judul: "Etika dan Profesi",
        deskripsi: "Kode etik",
        tanggal: "20 Oktober 2025",
      ),
      TugasModel(
        judul: "Pra Skripsi",
        deskripsi: "Identifikasi topik",
        tanggal: "25 Oktober 2025",
      ),
      TugasModel(
        judul: "Rekayasa Interaksi",
        deskripsi: "Prototype",
        tanggal: "26 Oktober 2025",
      ),
    ]);
  }

  void toggleCheck(int index) {
    listTugas[index].isDone = !listTugas[index].isDone;
    listTugas.refresh();
  }

  void hapusTugas(int index) {
    listTugas.removeAt(index);
  }

  void editTugas(int index, TugasModel tugasBaru) {
    listTugas[index] = tugasBaru;
  }

  void tambahTugas(TugasModel tugas) {
    listTugas.add(tugas);

    Get.snackbar(
      "Berhasil",
      "Tugas berhasil ditambahkan!",
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }
}


