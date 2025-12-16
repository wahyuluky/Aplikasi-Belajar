/* NOTES SAMA KAYA DI TUGAS_MODEL.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddtugasController extends GetxController {

  // Controller untuk input
  TextEditingController tugasC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();
  TextEditingController tanggalC = TextEditingController();

  RxBool isDone = false.obs;

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance;


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

  Future<void> tambahTugas() async {
    if (tugasC.text.isEmpty) {
      Get.snackbar("Error", "Judul tugas wajib diisi");
      return;
    }

    await firestore
        .collection("users")
        .doc(uid)
        .collection("tugas")
        .add({
      "judul": tugasC.text,
      "deskripsi": keteranganC.text,
      "tanggal": tanggalC.text,
      "isDone": isDone.value,
      "createdAt": DateTime.now(),
    });

    Get.back();
    Get.snackbar("Sukses", "Tugas berhasil ditambahkan");
  }
}
--------------------------------------------------------------------*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../tugas/controllers/tugas_controller.dart';
import '../../tugas/controllers/tugas_model.dart';

class AddtugasController extends GetxController {
  // Text controller
  TextEditingController tugasC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();
  TextEditingController tanggalC = TextEditingController();

  RxBool isDone = false.obs;
  DateTime? selectedDate;

  // Ambil controller tugas (DATA LOKAL)
  final TugasController tugasController = Get.find<TugasController>();

  // 🔁 RESET FORM (AGAR SELALU KOSONG)
  @override
  void onInit() {
    super.onInit();
    resetForm();
  }

  void resetForm() {
    tugasC.clear();
    keteranganC.clear();
    tanggalC.clear();
    selectedDate = null;
    isDone.value = false;
  }

  // 📅 PILIH TANGGAL (HANYA MASA DEPAN)
  void pilihTanggal(BuildContext context) async {
    final DateTime now = DateTime.now();

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)), // default besok
      firstDate: now.add(const Duration(days: 1)),   // 🔥 minimal besok
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate = picked;
      tanggalC.text =
          "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
    }
  }

  // ➕ TAMBAH TUGAS
  void tambahTugas() {
    if (tugasC.text.isEmpty || selectedDate == null) {
      Get.snackbar("Error", "Judul dan tanggal wajib diisi");
      return;
    }

    tugasController.tambahTugas(
      TugasModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        judul: tugasC.text,
        deskripsi: keteranganC.text,
        tanggal: selectedDate!,
        isDone: isDone.value,
      ),
    );

    resetForm();
    Get.back();
    Get.snackbar("Sukses", "Tugas berhasil ditambahkan");
  }

  @override
  void onClose() {
    tugasC.dispose();
    keteranganC.dispose();
    tanggalC.dispose();
    super.onClose();
  }
}
