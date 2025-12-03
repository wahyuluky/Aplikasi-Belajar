import 'package:flutter_application_1/app/modules/materi/controllers/materi_model.dart';
import 'package:get/get.dart';

class MateriController extends GetxController {
  RxList<MateriModel> materiList = <MateriModel>[
    MateriModel(title: "Pertemuan 1_Rekayasa Interaksi", isPdf: false),
    MateriModel(title: "Pertemuan 2_Rekayasa Interaksi", isPdf: true),
    MateriModel(title: "Pertemuan 3_Rekayasa Interaksi", isPdf: false),
    MateriModel(title: "Pertemuan 4_Rekayasa Interaksi", isPdf: true),
    MateriModel(title: "Pertemuan 5_Rekayasa Interaksi", isPdf: false),
  ].obs;

  void onItemTap(int index) {
    // aksi saat materi diklik, bisa diarahkan ke viewer pdf atau detail materi
    print("Materi diklik: ${materiList[index].title}");
  }
}
