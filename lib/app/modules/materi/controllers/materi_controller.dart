import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/materi/controllers/materi_model.dart';

class MateriController extends GetxController {
  RxList<MateriModel> materiList = <MateriModel>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var groupName = "".obs;

  Future<void> loadGroupInfo(String groupId) async {
    final doc = await FirebaseFirestore.instance
        .collection('grup_belajar')
        .doc(groupId)
        .get();

    if (doc.exists) {
      groupName.value = doc.data()?['nama'] ?? 'Grup Belajar';
    } else {
      groupName.value = 'nama_grup';
    }
  }

  void loadMateriFromChat(String groupId) {
    _firestore
        .collection('grup_belajar')
        .doc(groupId)
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      final temp = <MateriModel>[];

      for (final doc in snapshot.docs) {
        final data = doc.data();

        // 🔴 HANYA AMBIL IMAGE
       if (data['type'] == 'image' && data['imageBase64'] != null) {
          final timestamp = data['createdAt'] as Timestamp?;
          final date = timestamp?.toDate();

          final formattedDate = date != null
              ? "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}"
              : "Waktu tidak diketahui";

          temp.add(
            MateriModel(
              title: "Gambar Diskusi • $formattedDate",
              isPdf: false,
              type: "image",
              imageBase64: data['imageBase64'],
            ),
          );
        }
      }

      materiList.value = temp;
    });
  }

  void onItemTap(BuildContext context, int index) {
    final materi = materiList[index];

    if (materi.type == "image" && materi.imageBase64 != null) {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: InteractiveViewer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  base64Decode(materi.imageBase64!),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

}