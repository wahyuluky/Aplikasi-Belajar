import 'package:get/get.dart';

class ChooseFriendController extends GetxController {
  RxList<Map<String, String>> friends = <Map<String, String>> [
    {"name": "Putri Nabila"},
    {"name": "Ernaya Fitri"},
    {"name": "Nadra Tan"},
    {"name": "Wahyu Lukytaningtyas"},
    {"name": "Jauza Wijdaniah"},
  ].obs;


   // jumlah lagu dipilih
  RxInt selectedCount = 0.obs;

  // list lagu

  // list boolean untuk seleksi lagu
  RxList<bool> selected = <bool>[].obs;

  @override
  void onInit() {
    // set selected sesuai panjang musicList
    // selected = List<bool>.filled(friends.length, false).obs;
    selected = List.generate(friends.length, (_) => false).obs;
    super.onInit();
  }

  // fungsi memilih lagu
  void toggleSelect(int index) {
    selected[index] = !selected[index];
    // selectedCount.value = selected.where((e) => e == true).length;
    selected.refresh(); 
  }

  // Update jumlah otomatis
  void updateSelectedCount() {
    selectedCount.value = selected.where((e) => e).length;
  }

   // Wrapper untuk toggle sambil update count
  void toggleAndCount(int index) {
    toggleSelect(index);
    updateSelectedCount();
  }
}
