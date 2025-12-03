import 'package:flutter_application_1/app/modules/anggota/controllers/anggota_model.dart';
import 'package:get/get.dart';

class AnggotaController extends GetxController {
  RxList<AnggotaModel> anggotaList = <AnggotaModel>[
    AnggotaModel(name: "Putri Nabila", avatar: "assets/user1.jpg"),
    AnggotaModel(name: "Ernaya Fitri", avatar: "assets/user2.jpg"),
    AnggotaModel(name: "Nadra Tan", avatar: "assets/user3.jpg"),
    AnggotaModel(name: "Wahyu Lukytaningtyas", avatar: "assets/user4.jpg"),
    AnggotaModel(name: "Jauza Wijianiah", avatar: "assets/user5.jpg"),
  ].obs;

  void addAnggota(String name, String avatar) {
    anggotaList.add(AnggotaModel(name: name, avatar: avatar));
  }
}
