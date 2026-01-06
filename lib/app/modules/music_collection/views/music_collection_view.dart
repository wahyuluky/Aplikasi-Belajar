import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/music_collection/controllers/music_collection_controller.dart';
import 'package:flutter_application_1/app/modules/play_music/bindings/play_music_binding.dart';
import 'package:flutter_application_1/app/modules/play_music/views/play_music_view.dart';

class MusicCollectionView extends StatelessWidget {
  final MusicCollectionController controller =
      Get.put(MusicCollectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.white,),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Koleksi Musik",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF74E4A2), Color(0xFF93D8FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
          children: [
            const SizedBox(height: 10),
            _titleRow(),
            const SizedBox(height: 10),
            Expanded(child: _musicList()),
          ],
        ),
    );
  }

  // ---------------- TITLE + SEARCH + ADD ----------------
  Widget _titleRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text(
            "Koleksi Musik",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          // SEARCH BAR
          Container(
            width: 140,
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    onChanged: (v) => controller.search.value = v,
                    decoration: const InputDecoration(
                      hintText: "Tulis disini",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.only(bottom: 15)
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // ADD BUTTON
          GestureDetector(
            onTap: (){
              controller.addMusic();
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 20),
            ),
          )
        ],
      ),
    );
  }

  // ---------------- MUSIC LIST ----------------
  Widget _musicList() {
    return Obx(() {
      var filtered = controller.musicList.where((item) {
        var q = controller.search.value.toLowerCase();
        var title = item["title"] ?? "";
        var artist = item["artist"] ?? "";
        return title.toLowerCase().contains(q) ||
            artist.toLowerCase().contains(q);
      }).toList();

      if (filtered.isEmpty) {
        return const Center(
          child: Text("Belum ada musik", style: TextStyle(fontSize: 12)),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filtered.length,
        itemBuilder: (context, i) {
          final music = filtered[i];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              onTap: () {
                controller.currentIndex.value = i;
                // controller.playMusic(controller.musicList[i]["path"]!);

                Get.to(
                  () => PlayMusicView(),
                  arguments: i, // ✅ KIRIM INDEX
                  binding: PlayMusicBinding(),
                );
              },
              child: Row(
                children: [
                  // ICON (ganti image)
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green.shade100,
                    child: const Icon(Icons.music_note, color: Colors.green),
                  ),

                  const SizedBox(width: 12),

                  // TEXT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          music["title"] ?? "Unknown Title",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          music["artist"] ?? "Unknown Artist",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // DELETE
                  GestureDetector(
                    onTap: () => showDeleteDialog(i),
                    child: Row(
                      children: const [
                        Icon(Icons.delete, color: Colors.red, size: 20),
                        SizedBox(width: 4),
                        Text(
                          "Hapus",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  void showDeleteDialog(int index) {
    Get.defaultDialog(
      title: "",
      backgroundColor: Colors.white,
      radius: 20,
      content: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.red.shade100,
            child: const Icon(
              Icons.delete_forever,
              color: Colors.red,
              size: 32,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Hapus Lagu?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Tindakan ini tidak dapat dibatalkan.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text("Batal", style: TextStyle(color: Colors.black),),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    controller.deleteMusic(index);
                    Get.back();
                    Get.snackbar( 
                      "Sukses",
                      "Lagu berhasil dihapus",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.TOP,
                    );
                  },
                  child: const Text("Hapus", style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}

