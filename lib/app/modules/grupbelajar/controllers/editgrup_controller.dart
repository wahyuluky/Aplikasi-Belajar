import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditgrupController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxString foto = "".obs;

  String groupId = "";
  
  TextEditingController namaGrupC = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void pilihFoto() async {
    // Note: jika ingin mengambil dari gallery, bisa ditambahkan image_picker.
    foto.value = "https://picsum.photos/200?random=${DateTime.now().millisecondsSinceEpoch}";
  }

  Future<void> updateGrup(String groupId, String nama, String foto) async {
    try {
      await firestore.collection("grup_belajar").doc(groupId).update({
        'nama': nama,
        'foto': foto,
        'updatedAt': DateTime.now().toIso8601String(),
      });
      Get.back();
      Get.snackbar(
        "Sukses", 
        "Grup berhasil diperbarui",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.snackbar(
        "Error", 
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);
    }
  }


}
