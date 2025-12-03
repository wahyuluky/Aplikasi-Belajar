import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/koleksi_musik_controller.dart';

final controller = Get.put(KoleksiMusikController());

class KoleksiMusikView extends GetView<KoleksiMusikController> {
  const KoleksiMusikView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ========================= APPBAR =========================
          Container(
            padding:
                const EdgeInsets.only(top: 45, left: 15, right: 15, bottom: 15),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7BC6FF), Color(0xFF2CE58D)],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Koleksi Musik",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ========================= SEARCH =========================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: TextField(
                      onChanged: controller.updateSearch,
                      decoration: const InputDecoration(
                        icon:
                            Icon(Icons.search, size: 20, color: Colors.black38),
                        hintText: "Tulis disini",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Button Tambah (belum ada fungsi)
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF48E06C),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ========================= LIST =========================
          Expanded(
            child: Obx(() {
              // Filter berdasarkan search
              final filtered = controller.musicList.where((m) {
                final q = controller.searchQuery.value.toLowerCase();
                return m["title"]!.toLowerCase().contains(q) ||
                    m["artist"]!.toLowerCase().contains(q);
              }).toList();

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final item = filtered[index];
                  return MusikItem(
                    title: item["title"]!,
                    artist: item["artist"]!,
                    onDelete: () {
                      controller.deleteItem(controller.musicList.indexOf(item));
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// ITEM MUSIK
// =====================================================

class MusikItem extends StatelessWidget {
  final String title;
  final String artist;
  final VoidCallback onDelete;

  const MusikItem({
    super.key,
    required this.title,
    required this.artist,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          // FOTO BULAT
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFEAEAEA),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.music_note, color: Colors.black54),
          ),

          const SizedBox(width: 15),

          // TITLE + ARTIST
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                artist,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ],
          ),

          const Spacer(),

          // BUTTON HAPUS
          GestureDetector(
            onTap: onDelete,
            child: Row(
              children: const [
                Icon(Icons.delete, color: Colors.red, size: 22),
                SizedBox(width: 4),
                Text("Hapus",
                    style: TextStyle(color: Colors.red, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
