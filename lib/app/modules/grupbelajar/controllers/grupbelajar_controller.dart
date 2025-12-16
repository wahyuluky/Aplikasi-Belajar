import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrupbelajarController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  
  RxList<Map<String, dynamic>> grupList = <Map<String, dynamic>>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadUserGroups();
  }

  // Ambil grup yang diikuti user
  void loadUserGroups() {
    firestore
        .collection("users")
        .doc(userId)
        .collection("joined_groups")
        .snapshots()
        .listen((snapshot) async {
      grupList.clear();

      for (var doc in snapshot.docs) {
        var grupId = doc.id;

        var grupData = await firestore.collection("grup_belajar").doc(grupId).get();

        if (grupData.exists) {
          grupList.add({
            "id": grupId,
            "nama": grupData["nama"],
            "foto": grupData["foto"],
          });
        }
      }
    });
  }

  /// Tambah Grup
  Future<void> tambahGrup(String namaGrup, String foto) async {
    String groupId = firestore.collection("grup_belajar").doc().id;

    // 1. Buat grup di koleksi grup_belajar
    await firestore.collection("grup_belajar").doc(groupId).set({
      "nama": namaGrup,
      "foto": foto,
      "createdAt": DateTime.now(),
      "createdBy": userId,
    });

    // 2. Tambahkan pembuat ke subcollection members
    await firestore
        .collection("grup_belajar")
        .doc(groupId)
        .collection("members")
        .doc(userId)
        .set({
      "role": "admin",
      "joinedAt": DateTime.now(),
    });

    // 3. Tambahkan grup ke joined_groups user
    await firestore
        .collection("users")
        .doc(userId)
        .collection("joined_groups")
        .doc(groupId)
        .set({"joined": true});

    Get.snackbar("Berhasil", "Grup berhasil dibuat",
        backgroundColor: Colors.green, colorText: Colors.white);
  }


  /// Hapus Grup
  Future<void> deleteGrup(String grupId) async {
  await firestore.collection("grup_belajar").doc(grupId).delete();

  await firestore
      .collection("users")
      .doc(userId)
      .collection("joined_groups")
      .doc(grupId)
      .delete();

  Get.snackbar("Berhasil", "Grup berhasil dihapus",
    backgroundColor: Colors.green, colorText: Colors.white);
  }


  /// Edit (Update)
  Future<void> editGrup(String docId, String namaBaru, String fotoBaru) async {
    await firestore.collection("grup_belajar").doc(docId).update({
      "nama": namaBaru,
      "foto": fotoBaru,
    });
    Get.snackbar("Berhasil", "Grup berhasil diupdate",
        backgroundColor: Colors.blue, colorText: Colors.white);
  }

}


