import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/grupbelajar/controllers/tambahgrup_controller.dart';

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

  Future<void> tambahGrup(String namaGrup, String foto) async {
  String groupId = firestore.collection("grup_belajar").doc().id;

  await firestore.collection("grup_belajar").doc(groupId).set({
    "nama": namaGrup,
    "foto": foto,
    "createdAt": DateTime.now(),
    "createdBy": userId,
  });

  await firestore
      .collection("grup_belajar")
      .doc(groupId)
      .collection("members")
      .doc(userId)
      .set({
    "role": "admin",
    "joinedAt": DateTime.now(),
  });

  await firestore
      .collection("users")
      .doc(userId)
      .collection("joined_groups")
      .doc(groupId)
      .set({"joined": true});

  Get.back(); // tutup popup
  Get.delete<TambahgrupController>(); // ✅ FIX ERROR dispose

  Get.snackbar(
    "Berhasil",
    "Grup berhasil dibuat",
    backgroundColor: Colors.green,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
  );
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
    backgroundColor: Colors.green, colorText: Colors.white, snackPosition: SnackPosition.TOP);
  }


  /// Edit (Update)
  Future<void> editGrup(String docId, String namaBaru, String fotoBaru) async {
    await firestore.collection("grup_belajar").doc(docId).update({
      "nama": namaBaru,
      "foto": fotoBaru,
    });
    Get.snackbar("Berhasil", "Grup berhasil diupdate",
        backgroundColor: Colors.green, colorText: Colors.white, snackPosition: SnackPosition.TOP);
  }

  Future<void> leaveGroup(String grupId) async {
    // hapus dari members grup
    await firestore
        .collection("grup_belajar")
        .doc(grupId)
        .collection("members")
        .doc(userId)
        .delete();

    // hapus dari joined_groups user
    await firestore
        .collection("users")
        .doc(userId)
        .collection("joined_groups")
        .doc(grupId)
        .delete();

    Get.snackbar(
      "Berhasil",
      "Anda telah keluar dari grup",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }


}


