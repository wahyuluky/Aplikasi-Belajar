import 'dart:async';
import 'package:get/get.dart';

class FocusTimerController extends GetxController {
  // waktu fokus default 25 menit (1500 detik)
  final int totalSeconds = 1500;

  RxInt remainingSeconds = 1500.obs;
  Timer? timer;

  RxBool isRunning = false.obs;
  RxBool isFinished = false.obs;

  // target belajar contoh: 3 dari 4
  RxInt completed = 3.obs;
  int target = 4;

  void startTimer() {
    if (isRunning.value) return;

    isRunning.value = true;
    isFinished.value = false;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        t.cancel();
        isRunning.value = false;
        isFinished.value = true;
      }
    });
  }

  void pauseTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    isRunning.value = false;
  }

  void resetTimer() {
    pauseTimer();
    remainingSeconds.value = totalSeconds;
    isFinished.value = false;

    // opsional: tambah progress
    if (completed.value < target) {
      completed.value++;
    }
  }

  String formatTime(int seconds) {
    double minutes = seconds / 60;
    return minutes.toStringAsFixed(2); // 25.00
  }

  double get progress {
    return 1 - (remainingSeconds.value / totalSeconds);
  }
}
