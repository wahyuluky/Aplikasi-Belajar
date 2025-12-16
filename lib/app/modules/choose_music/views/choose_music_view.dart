import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/choose_music_controller.dart';

class ChooseMusicView extends StatelessWidget {
  final c = Get.put(ChooseMusicController());

  ChooseMusicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.white,),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Tambah Lagu",
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
          // SEARCH BAR
        // ====== FIXED: Search Bar Menggunakan bottom AppBar ======
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Container(
              height: 39,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey, size: 18),
                  SizedBox(width: 3),
                  Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                        hintText: "Tulis disini",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12)
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
          children: [
            const SizedBox(height: 8),
            _selectedInfo(),
            const Divider(height: 1),
            Expanded(child: _musicList()),
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
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 30),
            const Icon(Icons.play_arrow, size: 24),
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
                  radius: 18,
                  backgroundImage: AssetImage(item["image"]!),
                ),
                title: Text(
                  item["title"]!,
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.green[800] : Colors.black,
                    fontSize: 12,
                  ),
                ),
                subtitle: Text(item["artist"]!, style: const TextStyle(fontSize: 10),),

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
  ));
}
