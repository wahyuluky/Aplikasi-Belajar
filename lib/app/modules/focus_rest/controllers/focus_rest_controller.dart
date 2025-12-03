import 'package:get/get.dart';

class FocusRestController extends GetxController {
  // progress bar value (0–20 block)
  var progress = 15.obs;

  // lama fokus
  var focusedMinutes = 25.obs;

  void playRelaxingMusic() {
    // action when user presses button
    print("Play relaxing music...");
  }
}
