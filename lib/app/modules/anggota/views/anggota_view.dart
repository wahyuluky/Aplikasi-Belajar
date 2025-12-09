import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../chat/views/chat_view.dart';
import '../../grupbelajar/views/grupbelajar_view.dart';
import '../../materi/views/materi_view.dart';
import '../controllers/anggota_controller.dart';

class AnggotaView extends StatelessWidget {
  final String groupId;
  final String groupName;

  AnggotaView({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  final AnggotaController controller = Get.put(AnggotaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _buildAppBar(),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6BE585), Color(0xFF6BB4FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: _buildTabs(),
          ),

          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.anggotaList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final anggota = controller.anggotaList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.green.shade50
                            : Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 14),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: AssetImage(anggota.avatar),
                          ),
                          const SizedBox(width: 14),
                          Text(
                            anggota.name,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  },
                )),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade100,
        onPressed: () {
          // contoh: pindah ke choose friend
          // Get.to(ChooseFriendView());
        },
        child: const Icon(Icons.add, color: Colors.black, size: 28),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF74E4A2), Color(0xFF93D8FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Text(
        groupName,
        style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
        onPressed: () => Get.back(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.people_alt_rounded,
              size: 18, color: Colors.white),
          onPressed: () {
            Get.to(GrupbelajarView());
          },
        ),
      ],
      elevation: 0,
    );
  }

  Widget _buildTabs() {
    return Container(
      color: const Color(0xffF8F8F8),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _tabItem("DISKUSI", false, () {
            Get.off(() => ChatView(
                  groupId: groupId,
                  groupName: groupName,
                ));
          }),
          _tabItem("MATERI", false, () {
            Get.off(() => MateriView(
                  groupId: groupId,
                  groupName: groupName,
                ));
          }),
          _tabItem("ANGGOTA", true, () {}),
        ],
      ),
    );
  }
}

Widget _tabItem(String title, bool isActive, VoidCallback onTap) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        color: isActive ? const Color(0xffCCF2CD) : Colors.white,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ),
    ),
  );
}
