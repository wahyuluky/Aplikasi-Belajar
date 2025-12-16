import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/chat/views/chat_view.dart';
import 'package:flutter_application_1/app/modules/choose_friend/views/choose_friend_view.dart';
import 'package:flutter_application_1/app/modules/grupbelajar/views/grupbelajar_view.dart';
import 'package:flutter_application_1/app/modules/materi/views/materi_view.dart';
import 'package:flutter_application_1/app/modules/profile_teman/views/profile_teman_view.dart';
import '../controllers/anggota_controller.dart';

class AnggotaView extends StatelessWidget {
  final AnggotaController controller = Get.put(AnggotaController());
  final String groupId;

  AnggotaView({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    controller.loadGroupInfo(groupId); 
    controller.loadMembers(groupId);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _buildAppBar(),
      ),
      body: Column(
        children: [
          // TAB (DISKUSI - MATERI - ANGGOTA)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6BE585), Color(0xFF6BB4FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: _buildTabs()
          ),

          // LIST ANGGOTA
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.anggotaList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final anggota = controller.anggotaList[index];
                    return GestureDetector(
                      onTap: (){
                        Get.to(() => ProfileTemanView(userId: anggota.uid));
                      },
                      child: Container(
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
                            backgroundImage: NetworkImage(anggota.fotoUrl),
                          ),
                          const SizedBox(width: 14),
                          Text(
                            anggota.username,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 10,),
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.red,
                          //   ),
                          //   onPressed: () => controller.leaveGroup(groupId),
                          //   child: const Text("Keluar Grup", style: TextStyle(fontSize: 10, color: Colors.white),),
                          // )
                        ],
                      ),
                    ),
                    );
                  },
                )),
          ),
        ],
      ),

      // FLOATING BUTTON (+)
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade100,
        onPressed: () {
          // Diisi untuk action tambah anggota
          Get.to(ChooseFriendView(groupId: groupId,));
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
      title: Obx(() => Text(
              controller.groupName.value,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            )),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18,),
        onPressed: () => Get.back(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.people_alt_rounded, size: 18, color: Colors.white,),
          onPressed: () {
            Get.to(GrupbelajarView());
          },
        ),
      ],
      elevation: 0,
    );
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

    Widget _buildTabs() {
    return Container(
      color: const Color(0xffF8F8F8),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _tabItem("DISKUSI", false, () {
            Get.to(() => ChatView(groupId: groupId));
          }),
          _tabItem("MATERI", false, () {
            Get.to(() => MateriView(groupId: groupId,));
          }),
          _tabItem("ANGGOTA", true, () {

          }),
        ],
      ),
    );
  }
}

