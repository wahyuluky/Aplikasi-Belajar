import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GrupbelajarController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  RxList<Map<String, dynamic>> grupList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserGroups();
  }

  void loadUserGroups() {
    firestore
        .collection("users")
        .doc(userId)
        .collection("joined_groups")
        .snapshots()
        .listen((snapshot) async {
      final List<Map<String, dynamic>> temp = [];

      for (var doc in snapshot.docs) {
        final grup =
            await firestore.collection("grup_belajar").doc(doc.id).get();

        if (grup.exists) {
          temp.add({
            "id": doc.id,
            "nama": grup["nama"],
            "foto": grup["foto"],
          });
        }
      }

      grupList.value = temp;
    });
  }

  Future<void> tambahGrup(String nama, String foto) async {
    final groupRef = firestore.collection("grup_belajar").doc();
    final groupId = groupRef.id;

    await groupRef.set({
      "nama": nama,
      "foto": foto,
      "createdBy": userId,
      "createdAt": FieldValue.serverTimestamp(),
    });

    await groupRef.collection("members").doc(userId).set({
      "role": "admin",
      "joinedAt": FieldValue.serverTimestamp(),
    });

    await firestore
        .collection("users")
        .doc(userId)
        .collection("joined_groups")
        .doc(groupId)
        .set({"joined": true});
  }
}
