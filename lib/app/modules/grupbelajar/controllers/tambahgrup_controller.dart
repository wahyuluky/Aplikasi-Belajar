import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TambahgrupController extends GetxController {
  TextEditingController namaGrupC = TextEditingController();

  // foto default
  RxString fotoUrl = "https://picsum.photos/200".obs;

  void pilihFoto() async {
    // Note: jika ingin mengambil dari gallery, bisa ditambahkan image_picker.
    fotoUrl.value = "https://picsum.photos/200?random=${DateTime.now().millisecondsSinceEpoch}";
  }
}
