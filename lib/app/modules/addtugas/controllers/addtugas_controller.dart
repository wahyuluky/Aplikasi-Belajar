import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddtugasController extends GetxController {
  TextEditingController tugasC = TextEditingController();
  TextEditingController ketC = TextEditingController();
  TextEditingController tanggalC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void tambahTugas() async {
    if (tugasC.text.isEmpty || tanggalC.text.isEmpty) {
      Get.snackbar('Error', 'Judul & tanggal wajib diisi');
      return;
    }

    await firestore.collection('tugas').add({
      'nama_tugas': tugasC.text,
      'keterangan': ketC.text,
      'tanggal': Timestamp.fromDate(DateTime.parse(tanggalC.text)),
      'isDone': false,
      'created_at': Timestamp.now(),
    });

    Get.back();
  }

  @override
  void onClose() {
    tugasC.dispose();
    ketC.dispose();
    tanggalC.dispose();
    super.onClose();
  }
}
