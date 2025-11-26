import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/choose_friend/controllers/choose_friend_controller.dart';

class ChooseFriendView extends StatelessWidget {
  final ChooseFriendController c = Get.put(ChooseFriendController());

  ChooseFriendView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 5),
            _selectedInfo(),
            const Divider(height: 1),
            Expanded(child: _friendList()),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
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
          // BARIS ATAS
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
                // SizedBox(width: 12),
                Icon(Icons.search, color: Colors.grey, size: 18),
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      hintText: "Tulis disini",
                      contentPadding: EdgeInsets.all(16),
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
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 300),

              Positioned(
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.send,
                    size: 22,
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
