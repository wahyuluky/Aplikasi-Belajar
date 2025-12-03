import 'package:get/get.dart';

class MusicCollectionController extends GetxController {
  RxList<Map<String, String>> musicList = <Map<String, String>>[
    {
      "image": "assets/music1.jpg",
      "title": "Duka",
      "artist": "Last Child",
    },
    {
      "image": "assets/music2.jpg",
      "title": "Seluruh nafas ini",
      "artist": "Last Child",
    },
    {
      "image": "assets/music3.jpg",
      "title": "Sahabat jadi cinta",
      "artist": "Zigaz",
    },
  ].obs;

  RxString search = "".obs;

  void deleteMusic(int index) {
    musicList.removeAt(index);
  }

  void addMusic() {
    // Contoh action
    print("Tambah musik ditekan");
  }
}
