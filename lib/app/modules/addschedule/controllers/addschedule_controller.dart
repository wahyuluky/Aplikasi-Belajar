import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddscheduleController extends GetxController {
  final subjectC = TextEditingController();
  final dateC = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> schedules = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSchedules();
  }


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
      snackPosition: SnackPosition.TOP
    );
  }

  // ====================== LOAD DATA ============================
  Future<void> loadSchedules() async {
    final uid = _auth.currentUser!.uid;

    await _firestore
        .collection("users")
        .doc(uid)
        .collection("schedules")
        .get();
  }

// ====================== ADD ============================
  Future<void> addSchedule(String title, String date) async {
    if (title.isEmpty || date.isEmpty) {
      Get.snackbar("Error", "Semua field harus diisi!",
          backgroundColor: Colors.red.withOpacity(0.2),
          colorText: Colors.red);
      return;
    }

    final uid = _auth.currentUser!.uid;

    await _firestore
        .collection("users")
        .doc(uid)
        .collection("schedules")
        .add({
      "title": title,
      "date": date,
      "createdAt": DateTime.now(),
    });

    Get.back();

    Get.snackbar(
      "Berhasil",
      "Jadwal berhasil ditambahkan!",
      backgroundColor: Colors.green.withOpacity(0.3),
      colorText: Colors.green.shade800,
      snackPosition: SnackPosition.TOP,
    );
  }
}


