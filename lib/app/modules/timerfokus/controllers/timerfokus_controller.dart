import 'dart:async';
import 'package:get/get.dart';

class TimerFokusController extends GetxController {
  RxDouble waktu = 25.0.obs; // menit
  RxBool isRunning = false.obs;

  Timer? timer;

  // Target belajar
  RxInt progress = 3.obs;
  RxInt totalTarget = 4.obs;

  void mulaiTimer() {
    if (isRunning.value) return;

    isRunning.value = true;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (waktu.value <= 0) {
        selesai();
        return;
      }
      waktu.value -= (1 / 60); // mengurangi 1 detik
    });
  }

  void jeda() {
    isRunning.value = false;
    timer?.cancel();
  }

  void selesai() {
    isRunning.value = false;
    timer?.cancel();
    waktu.value = 25.0;
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
