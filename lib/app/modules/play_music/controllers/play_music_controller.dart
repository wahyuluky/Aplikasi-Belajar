import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/music_collection/controllers/music_collection_controller.dart';

class PlayMusicController extends GetxController {
  final MusicCollectionController musicC =
      Get.find<MusicCollectionController>();

  RxBool isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg == null || arg is! int) {
        Get.back();
        Get.snackbar("Error", "Lagu tidak valid");
        return;
    }

    musicC.playMusicAt(arg);

    musicC.player.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
  }

  Map<String, String> get song {
    final i = musicC.currentIndex.value;
    if (i < 0 || i >= musicC.musicList.length) return {};
    return musicC.musicList[i];
  }

  void togglePlay() {
    isPlaying.value
        ? musicC.player.pause()
        : musicC.player.play();
  }

  void next() => musicC.playNext();
  void previous() => musicC.playPrevious();
}

