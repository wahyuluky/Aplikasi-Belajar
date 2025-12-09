import 'package:get/get.dart';
import 'package:flutter/material.dart';

class GrupbelajarController extends GetxController {
  RxList<Map<String, String>> grupList = <Map<String, String>>[
    {"id": "1", "nama": "Rekayasa Interaksi", "foto": "https://picsum.photos/200?1"},
    {"id": "2", "nama": "Rekayasa Ulang Sistem", "foto": "https://picsum.photos/200?2"},
    {"id": "3", "nama": "Rekayasa Kebutuhan", "foto": "https://picsum.photos/200?3"},
    {"id": "4", "nama": "Pra Skripsi", "foto": "https://picsum.photos/200?4"},
    {"id": "5", "nama": "Etika dan Profesi", "foto": "https://picsum.photos/200?5"},
    {"id": "6", "nama": "Jaringan Komputer", "foto": "https://picsum.photos/200?6"},
  ].obs;
 
  void tambahGrup(String nama, String foto) {
    grupList.add({"nama": nama, "foto": foto});
  }
 
  void deleteGrup(int index) {
    grupList.removeAt(index);
  }

  void editGrup(int index, String nama, String foto) {
    grupList[index] = {
      "nama": nama,
      "foto": foto,
    };
    grupList.refresh();
  }

}
