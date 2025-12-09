import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'tugas_model.dart';

class TugasController extends GetxController {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  
  var listTugas = <TugasModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _listenTugas();   // Realtime listener
  }

  // 🔥 LISTEN DATA REALTIME
  void _listenTugas() {
    String uid = _auth.currentUser!.uid;

    _db
        .collection("users")
        .doc(uid)
        .collection("tugas")
        .orderBy("tanggal")
        .snapshots()
        .listen((snapshot) {
      listTugas.value = snapshot.docs.map((doc) {
        return TugasModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  // 🔥 TOGGLE CHECKBOX
  Future<void> toggleCheck(TugasModel t) async {
    String uid = _auth.currentUser!.uid;

    await _db
        .collection("users")
        .doc(uid)
        .collection("tugas")
        .doc(t.id)
        .update({
      "isDone": !t.isDone,
    });
  }

  // 🔥 TAMBAH TUGAS
  Future<void> tambahTugas(TugasModel t) async {
    String uid = _auth.currentUser!.uid;

    await _db
        .collection("users")
        .doc(uid)
        .collection("tugas")
        .add(t.toMap());

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

  // 🔥 EDIT TUGAS
  Future<void> editTugas(TugasModel t) async {
    String uid = _auth.currentUser!.uid;

    await _db
        .collection("users")
        .doc(uid)
        .collection("tugas")
        .doc(t.id)
        .update(t.toMap());
  }

  // 🔥 HAPUS TUGAS
  Future<void> hapusTugas(String id) async {
    String uid = _auth.currentUser!.uid;

    await _db
        .collection("users")
        .doc(uid)
        .collection("tugas")
        .doc(id)
        .delete();
  }
}
