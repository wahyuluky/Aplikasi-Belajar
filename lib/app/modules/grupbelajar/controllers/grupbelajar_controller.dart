import 'dart:async'; // 🔥 WAJIB
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/data/auth_service.dart';

class GrupbelajarController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> grupList = <Map<String, dynamic>>[].obs;
  StreamSubscription? _sub;

  @override
  void onInit() {
    super.onInit();
    _listenUserGroups();
  }

  // ======================
  // LISTEN GRUP USER (REALTIME)
  // ======================
  void _listenUserGroups() {
    final user = AuthService.to.currentUser;
    if (user == null) {
      grupList.clear();
      return;
    }

    _sub?.cancel();
    _sub = firestore
        .collection("users")
        .doc(user.uid)
        .collection("joined_groups")
        .snapshots()
        .listen((snapshot) async {
      grupList.clear();

      for (final doc in snapshot.docs) {
        final groupId = doc.id;

        final grupDoc =
            await firestore.collection("grup_belajar").doc(groupId).get();

        if (grupDoc.exists) {
          final data = grupDoc.data()!;
          grupList.add({
            "id": groupId,
            "nama": data["nama"] ?? "-",
            "foto": data["foto"] ?? "https://picsum.photos/200",
          });
        }
      }
    });
  }

  // ======================
  // BUAT GRUP
  // ======================
  Future<void> tambahGrup(String namaGrup, String foto) async {
    final user = AuthService.to.currentUser;
    if (user == null) {
      Get.snackbar("Error", "Silakan login dulu");
      return;
    }

    final groupRef = firestore.collection("grup_belajar").doc();
    final groupId = groupRef.id;

    await groupRef.set({
      "nama": namaGrup,
      "foto": foto,
      "createdAt": FieldValue.serverTimestamp(),
      "createdBy": user.uid,
    });

    // admin member
    await groupRef.collection("members").doc(user.uid).set({
      "role": "admin",
      "joinedAt": FieldValue.serverTimestamp(),
    });

    // joined_groups
    await firestore
        .collection("users")
        .doc(user.uid)
        .collection("joined_groups")
        .doc(groupId)
        .set({
      "joined": true,
      "joinedAt": FieldValue.serverTimestamp(),
    });

    Get.snackbar(
      "Berhasil",
      "Grup berhasil dibuat",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // ======================
  // HAPUS GRUP
  // ======================
  Future<void> deleteGrup(String groupId) async {
    final user = AuthService.to.currentUser;
    if (user == null) return;

    await firestore.collection("grup_belajar").doc(groupId).delete();
    await firestore
        .collection("users")
        .doc(user.uid)
        .collection("joined_groups")
        .doc(groupId)
        .delete();

    Get.snackbar(
      "Berhasil",
      "Grup berhasil dihapus",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
