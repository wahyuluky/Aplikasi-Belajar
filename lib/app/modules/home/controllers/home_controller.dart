import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
  //TODO: Implement HomeController

  final count = 0.obs;



  void increment() => count.value++;
}
