import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditscheduleController extends GetxController {
  final subjectC = TextEditingController();
  final dateC = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> schedules = <Map<String, dynamic>>[].obs;

  String scheduleId = ""; // <-- ID jadwal yang akan di-edit

  @override
  void onInit() {
    super.onInit();

    // Ambil data dari page sebelumnya
    final data = Get.arguments;
    scheduleId = data["id"];
    subjectC.text = data["title"];
    dateC.text = data["date"];
  }

  // ====================== UPDATE ============================
  Future<void> updateSchedule() async {
    final uid = _auth.currentUser!.uid;

    if (subjectC.text.isEmpty || dateC.text.isEmpty) {
      Get.snackbar("Error", "Semua field harus diisi!");
      return;
    }

    await _firestore
        .collection("users")
        .doc(uid)
        .collection("schedules")
        .doc(scheduleId)
        .update({
      "title": subjectC.text,
      "date": dateC.text,
    });

    Get.back();
    Get.snackbar("Berhasil", "Jadwal berhasil diperbarui");
  }
}


