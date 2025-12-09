import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/materi_controller.dart';
import '../../chat/views/chat_view.dart';
import '../../anggota/views/anggota_view.dart';
import '../../grupbelajar/views/grupbelajar_view.dart';

class MateriView extends StatelessWidget {
  final String groupId;
  final String groupName;

  MateriView({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  final MateriController controller = Get.put(MateriController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _buildAppBar(),
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.materiList.length,
                  itemBuilder: (context, index) {
                    final materi = controller.materiList[index];
                    return InkWell(
                      onTap: () => controller.onItemTap(index),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        color: index % 2 == 0
                            ? Colors.green.shade50
                            : Colors.white,
                        child: Row(
                          children: [
                            Icon(
                              materi.isPdf
                                  ? Icons.picture_as_pdf
                                  : Icons.insert_drive_file,
                              color: materi.isPdf ? Colors.red : Colors.blue,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                materi.title,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff8EF58F), Color(0xff70C6FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Text(
        groupName,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.people_alt_rounded, color: Colors.white),
          onPressed: () {
            Get.to(() => GrupbelajarView());
          },
        )
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 45,
      color: const Color(0xffF8F8F8),
      child: Row(
        children: [
          _tabItem("DISKUSI", false, () {
            Get.to(() => ChatView(
                  groupId: groupId,
                  groupName: groupName,
                ));
          }),

          _tabItem("MATERI", true, () {}),

          _tabItem("ANGGOTA", false, () {
            Get.to(() => AnggotaView(
                  groupId: groupId,
                  groupName: groupName,
                ));
          }),
        ],
      ),
    );
  }

  Widget _tabItem(String title, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          color: active ? const Color(0xffCCF2CD) : Colors.white,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: active ? FontWeight.bold : FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
