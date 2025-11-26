import 'package:get/get.dart';

class PlayMusicController extends GetxController {
  RxBool isPlaying = false.obs;       // Play / Pause
  RxDouble progress = 185.0.obs;      // Posisi slider (detik)
  double duration = 240.0;            // Lama lagu 4 menit (240 detik)

  void togglePlay() {
    isPlaying.value = !isPlaying.value;
  }

  void changeProgress(double value) {
    progress.value = value;
  }
}
