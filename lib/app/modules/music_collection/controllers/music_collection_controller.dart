import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicCollectionController extends GetxController {
  final AudioPlayer player = AudioPlayer();
  RxInt currentIndex = (-1).obs;

  /// List musik lokal
  RxList<Map<String, String>> musicList = <Map<String, String>>[].obs;

  /// Search
  RxString search = "".obs;

  Future<void> playMusicAt(int index) async {
    if (index < 0 || index >= musicList.length) return;

    final path = musicList[index]["path"];
    if (path == null) return;

    currentIndex.value = index;

    try {
      await player.setFilePath(path);
      await player.play();
    } catch (e) {
      Get.snackbar("Error", "Gagal memutar audio");
    }
  }

  /// ============================
  /// PICK MUSIC DARI HP
  /// ============================
  Future<void> addMusic() async {
    await [
      Permission.audio,
      Permission.storage,
    ].request();

    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );

    if (result == null) return;

    for (var file in result.files) {
      if (file.path == null) continue;

      musicList.add({
        "path": file.path!,
        "title": file.name,
        "artist": "Local Music",
      });
    }
  }

  /// ============================
  /// PLAY MUSIC
  /// ============================
  Future<void> playMusic(String path) async {
    final file = File(path);

    if (!file.existsSync()) {
    Get.snackbar("Error", "File audio tidak ditemukan");
    return;
  }
    
    try {
      await player.setFilePath(path);
      await player.play();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal memutar audio",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("❌ Audio error: $e");
    }
  }

  void playNext() {
    if (musicList.isEmpty) return;
    int next = currentIndex.value + 1;
    if (next >= musicList.length) next = 0;
    playMusicAt(next);
  }

  void playPrevious() {
    if (musicList.isEmpty) return;
    int prev = currentIndex.value - 1;
    if (prev < 0) prev = musicList.length - 1;
    playMusicAt(prev);
  }


  /// ============================
  /// DELETE MUSIC
  /// ============================
  void deleteMusic(int index) {
    musicList.removeAt(index);
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
