import 'package:get/get.dart';

class ChooseMusicController extends GetxController {
  // Sample data
  RxList<Map<String, String>> musicList = <Map<String, String>>[
    {
      "title": "Duka",
      "artist": "Last Child",
      "image": "assets/m1.jpg",
    },
    {
      "title": "Seluruh nafas ini",
      "artist": "Last Child",
      "image": "assets/m2.jpg",
    },
    {
      "title": "Sahabat jadi cinta",
      "artist": "Zigaz",
      "image": "assets/m3.jpg",
    },
    {
      "title": "Bernafas tanpamu",
      "artist": "Last Child",
      "image": "assets/m4.jpg",
    },
    {
      "title": "Menjaga hati",
      "artist": "Yovie&Nuno",
      "image": "assets/m5.jpg",
    },
    {
      "title": "Playing with fire",
      "artist": "Blackpink",
      "image": "assets/m6.jpg",
    },
    {
      "title": "Black Mamba",
      "artist": "Aespa",
      "image": "assets/m7.jpg",
    },
    {
      "title": "TT",
      "artist": "Twice",
      "image": "assets/m8.jpg",
    },
    {
      "title": "Psycho",
      "artist": "Red Velvet",
      "image": "assets/m9.jpg",
    },
  ].obs;

 // jumlah lagu dipilih
  RxInt selectedCount = 0.obs;

  // list lagu

  // list boolean untuk seleksi lagu
  RxList<bool> selected = <bool>[].obs;

  @override
  void onInit() {
    // set selected sesuai panjang musicList
    selected = List<bool>.filled(musicList.length, false).obs;
    super.onInit();
  }

  // fungsi memilih lagu
  void toggleSelect(int index) {
    selected[index] = !selected[index];
    selectedCount.value = selected.where((e) => e == true).length;
  }
}
