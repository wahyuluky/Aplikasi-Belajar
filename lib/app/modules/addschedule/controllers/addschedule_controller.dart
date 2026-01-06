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

  // ====================== LOAD DATA ============================
  Future<void> loadSchedules() async {
    final uid = _auth.currentUser!.uid;

    final snap = await _firestore
        .collection("users")
        .doc(uid)
        .collection("schedules")
        .get();

    schedules.value = snap.docs.map((doc) {
      final data = doc.data();
      return {
        "id": doc.id,
        "title": data["title"],
        "date": data["date"],
        "createdAt": data["createdAt"],
      };
    }).toList();
  }

// ====================== ADD ============================
  Future<void> addSchedule() async {
    if (subjectC.text.isEmpty || dateC.text.isEmpty) {
      Get.snackbar(
        "Warning", 
        "Semua field harus diisi!",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP
      );
      return;
    }

    final uid = _auth.currentUser!.uid;

    await _firestore
        .collection("users")
        .doc(uid)
        .collection("schedules")
        .add({
      "title": subjectC.text,
      "date": dateC.text,
      "createdAt": DateTime.now(),
    });

    Get.back();

    Get.snackbar(
      "Berhasil",
      "Jadwal berhasil ditambahkan!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }
}


