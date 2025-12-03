import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrupbelajarController extends GetxController {
  RxList<Map<String, String>> grupList = <Map<String, String>>[
    {
      "nama": "Rekayasa Interaksi",
      "foto": "https://picsum.photos/200?1",
    },
    {
      "nama": "Rekayasa Ulang Sistem",
      "foto": "https://picsum.photos/200?2",
    },
    {
      "nama": "Rekayasa Kebutuhan",
      "foto": "https://picsum.photos/200?3",
    },
    {
      "nama": "Pra Skripsi",
      "foto": "https://picsum.photos/200?4",
    },
    {
      "nama": "Etika dan Profesi",
      "foto": "https://picsum.photos/200?5",
    },
    {
      "nama": "Jaringan Komputer",
      "foto": "https://picsum.photos/200?6",
    },
  ].obs;

  void tambahGrup(String nama, String foto) {
    grupList.add({
      "nama": nama,
      "foto": foto,
    });
  }

  void deleteGrup(int index) {
    grupList.removeAt(index);
    Get.snackbar("Berhasil", "Grup telah dihapus",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  void editGrup(int index) {
    // Bisa membuka popup edit
    Get.defaultDialog(
      title: "Edit Grup",
      content: Text("Fitur edit di sini"),
    );
  }

}


