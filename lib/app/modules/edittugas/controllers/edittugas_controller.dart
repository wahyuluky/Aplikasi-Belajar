import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EdittugasController extends GetxController {
  //TODO: Implement EdittugasController

  // Controller untuk input
  TextEditingController tugasC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();
  TextEditingController tanggalC = TextEditingController();

  RxBool isDone = false.obs;

  final firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  late String tugasId;

  @override
  void onInit() {
    super.onInit();

    // AMBIL DATA DARI ARGUMENTS
    tugasId = Get.arguments["id"];

    tugasC.text = Get.arguments["judul"];
    keteranganC.text = Get.arguments["deskripsi"];
    tanggalC.text = Get.arguments["tanggal"];
    isDone.value = Get.arguments["isDone"];
  }

  Future<void> simpan() async {
    if (tugasC.text.isEmpty || tanggalC.text.isEmpty) {
      Get.snackbar("Error", "Tugas dan tanggal wajib diisi");
      return;
    }

    await firestore
        .collection("users")
        .doc(uid)
        .collection("tugas")
        .doc(tugasId)
        .update({
      "judul": tugasC.text,
      "deskripsi": keteranganC.text,
      "tanggal": tanggalC.text,
      "isDone": isDone.value,
      "updatedAt": DateTime.now(),
    });

    Get.back();
    Get.snackbar("Sukses", "Data berhasil diperbarui");
  }


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
}
