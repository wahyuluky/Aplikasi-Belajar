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


