import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/choose_music/views/choose_music_view.dart';
import 'package:flutter_application_1/app/modules/music_collection/controllers/music_collection_controller.dart';
import 'package:flutter_application_1/app/modules/play_music/views/play_music_view.dart';

class MusicCollectionView extends StatelessWidget {
  final MusicCollectionController controller =
      Get.put(MusicCollectionController());

  MusicCollectionView({super.key});

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
              Get.to(ChooseMusicView());
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
    return Obx(
      () {
        var filtered = controller.musicList.where((item) {
          var q = controller.search.value.toLowerCase();
          return item["title"]!.toLowerCase().contains(q) ||
              item["artist"]!.toLowerCase().contains(q);
        }).toList();

      return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: filtered.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () {
                  Get.to(PlayMusicView());
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // IMAGE
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(filtered[i]["image"]!),
                    ),

                    const SizedBox(width: 12),

                    // TEXT
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filtered[i]["title"]!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            filtered[i]["artist"]!,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // DELETE BUTTON (aman)
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showDeleteDialog(i);
                      },
                      child: const Row(
                        children: [
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
      },
    );
  }

  void showDeleteDialog(int index) {
    Get.defaultDialog(
      title: "Hapus Lagu?",
      middleText: "Apakah kamu yakin ingin menghapus lagu ini?",
      textCancel: "Batal",
      textConfirm: "Hapus",
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.deleteMusic(index);
        Get.back();
      },
    );
  }
}



void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MusicCollectionView(),
  ));
}
