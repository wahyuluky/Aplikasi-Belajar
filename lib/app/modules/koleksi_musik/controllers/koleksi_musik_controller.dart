import 'package:get/get.dart';

class KoleksiMusikController extends GetxController {
  // List musik (dummy)
  var musicList = [
    {"title": "Duka", "artist": "Last Child"},
    {"title": "Seluruh Nafas Ini", "artist": "Last Child"},
    {"title": "Sahabat Jadi Cinta", "artist": "Zigaz"},
  ].obs;

  // Search
  var searchQuery = "".obs;

  // Update pencarian
  void updateSearch(String value) {
    searchQuery.value = value;
  }

  // Delete item
  void deleteItem(int index) {
    musicList.removeAt(index);
  }
}
