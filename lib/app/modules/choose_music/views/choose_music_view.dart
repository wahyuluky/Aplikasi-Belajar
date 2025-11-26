import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/choose_music_controller.dart';

class ChooseMusicView extends StatelessWidget {
  final c = Get.put(ChooseMusicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 8),
            _selectedInfo(),
            const Divider(height: 1),
            Expanded(child: _musicList()),
          ],
        ),
      ),
    );
  }

  // ================= HEADER ==================
  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF74E4A2), Color(0xFF93D8FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // TOP BAR
          SizedBox(
            height: 28,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 20),
                  ),
                ),
                const Text(
                  "Pilih teman",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.group,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // SEARCH BAR
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.grey, size: 18),
                SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      hintText: "Tulis disini",
                      contentPadding: EdgeInsets.only(bottom: 12),
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =============== SELECTED INFO =================
  Widget _selectedInfo() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${c.selectedCount.value} Lagu dipilih",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.play_arrow, size: 22),
          ],
        ),
      ),
    );
  }

  // ============= MUSIC LIST ======================
  Widget _musicList() {
    return Obx(
      () => ListView.builder(
        itemCount: c.musicList.length,
        itemBuilder: (context, i) {
          var item = c.musicList[i];
          bool isSelected = c.selected[i];

          return GestureDetector(
            onTap: () => c.toggleSelect(i),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.green.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage(item["image"]!),
                ),
                title: Text(
                  item["title"]!,
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.green[800] : Colors.black,
                  ),
                ),
                subtitle: Text(item["artist"]!),

                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const SizedBox(width: 10),
              ),
            ),
          );
        },
      ),
    );
  }
}


void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChooseMusicView(),
    initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => ChooseMusicView()),
      ],
  ));
}
