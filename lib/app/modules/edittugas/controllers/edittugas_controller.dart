import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EdittugasController extends GetxController {
  TextEditingController judulC = TextEditingController();
  TextEditingController ketC = TextEditingController();
  TextEditingController tanggalC = TextEditingController();

  late String id;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments;
    id = data['id'];
    judulC.text = data['judul'];
    ketC.text = data['deskripsi'];
    tanggalC.text =
        data['tanggal'].toString().substring(0, 10);
  }

  void updateTugas() async {
    await firestore.collection('tugas').doc(id).update({
      'nama_tugas': judulC.text,
      'keterangan': ketC.text,
      'tanggal': Timestamp.fromDate(DateTime.parse(tanggalC.text)),
    });

    Get.back();
  }
}
