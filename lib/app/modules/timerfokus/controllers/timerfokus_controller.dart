import 'dart:async';
import 'package:get/get.dart';

class TimerFokusController extends GetxController {
  RxInt sisaDetik = (25 * 60).obs; // 1500 detik
  RxBool isRunning = false.obs;
  

  Timer? timer;

  // Target belajar
  RxInt progress = 0.obs;
  RxInt totalTarget = 4.obs;

  void mulaiTimer() {
    if (isRunning.value) return;

    isRunning.value = true;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (sisaDetik.value <= 0) {
        selesai();
        return;
      }
      sisaDetik.value --; // mengurangi 1 detik
    });
  }

  void jeda() {
    isRunning.value = false;
    timer?.cancel();
  }

  void selesai() {
    isRunning.value = false;
    timer?.cancel();

    // 🎯 Tambah target belajar 1 sesi
    if (progress.value < totalTarget.value) {
      progress.value++;
    }

    // Reset ke 25 menit
    sisaDetik.value = 25 * 60;
  }

  String get formattedTime {
    final minutes = sisaDetik.value ~/ 60;
    final seconds = sisaDetik.value % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
