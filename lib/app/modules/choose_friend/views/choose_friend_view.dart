import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/grupbelajar/views/grupbelajar_view.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/choose_friend/controllers/choose_friend_controller.dart';

class ChooseFriendView extends StatelessWidget {
  final ChooseFriendController c = Get.put(ChooseFriendController());

  ChooseFriendView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Tambah Lagu",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
        centerTitle: true,

      // ICON GROUP (keluar dari search bar)
        actions: [
          IconButton(
            icon: const Icon(Icons.group, size: 20, color: Colors.white),
            onPressed: () => Get.to(GrupbelajarView()),
          ),
        ],

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF74E4A2), Color(0xFF93D8FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // ======== FIXED SEARCH BAR + ICON GRUP =========
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                // SEARCH BAR
                Expanded(
                  child: Container(
                    height: 39,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey, size: 18),
                        const SizedBox(width: 3),
                        const Expanded(
                          child: TextField(
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              hintText: "Tulis disini",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Column(
          children: [
            const SizedBox(height: 5),
            _selectedInfo(),
            const Divider(height: 1),
            Expanded(child: _friendList()),
          ],
        ),
    );
  }

  // ---------------- INFO TERPILIH ----------------
  Widget _selectedInfo() {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // agar tetap center
            children: [
              Text(
                "${c.selectedCount.value} Teman dipilih",
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              const SizedBox(width: 30),

              Positioned(
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.play_arrow,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  // ---------------- DAFTAR TEMAN ----------------
// ---------------- DAFTAR TEMAN ----------------
Widget _friendList() {
  return Obx(() => ListView.builder(
        itemCount: c.friends.length,
        itemBuilder: (context, index) {
          bool isSelected = c.selected[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.green.withOpacity(0.18) // highlight
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),

              onTap: () => c.toggleAndCount(index),

              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),

              title: Text(
                c.friends[index]['name']!,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? Colors.green[800] : Colors.black,
                  fontSize: 12,
                ),
              ),

              trailing: isSelected
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const SizedBox(width: 10),
            ),
          );
        },
      ));
  }

}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChooseFriendView(),
  ));
}
