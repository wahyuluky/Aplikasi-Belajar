import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/anggota/views/anggota_view.dart';
import 'package:flutter_application_1/app/modules/chat/views/chat_view.dart';
import 'package:flutter_application_1/app/modules/grupbelajar/views/grupbelajar_view.dart';
import 'package:get/get.dart';
import '../controllers/materi_controller.dart';

class MateriView extends StatelessWidget {
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
          // TAB (DISKUSI - MATERI - ANGGOTA)
          _buildTabs(),

          // LIST MATERI
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.materiList.length,
                  itemBuilder: (context, index) {
                    final materi = controller.materiList[index];
                    return InkWell(
                      onTap: () => controller.onItemTap(index),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? Colors.green.shade50
                              : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              materi.isPdf
                                  ? Icons.picture_as_pdf
                                  : Icons.insert_drive_file,
                              color: materi.isPdf ? Colors.red : Colors.blue,
                              size: 24,
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
      title: const Text(
        "Rekayasa Interaksi",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
      ),
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
            Get.to(() => ChatView());
          }),
          _tabItem("MATERI", true, () {
            
          }),
          _tabItem("ANGGOTA", false, () {
            Get.to(() => AnggotaView());
          }),
        ],
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MateriView(),
  ));
}
