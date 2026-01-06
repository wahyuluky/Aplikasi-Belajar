import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TambahgrupController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  
  RxList<Map<String, dynamic>> grupList = <Map<String, dynamic>>[].obs;
  TextEditingController namaGrupC = TextEditingController();

  // foto default
  RxString fotoUrl = "https://picsum.photos/200".obs;

  void pilihFoto() async {
    // Note: jika ingin mengambil dari gallery, bisa ditambahkan image_picker.
    fotoUrl.value = "https://picsum.photos/200?random=${DateTime.now().millisecondsSinceEpoch}";
  }

}
