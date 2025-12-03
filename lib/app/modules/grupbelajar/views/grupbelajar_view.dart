import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/chat/views/chat_view.dart';
import 'package:flutter_application_1/app/modules/grupbelajar/views/editgrup_popup.dart';
import 'package:flutter_application_1/app/modules/grupbelajar/views/tambahgrup_popup.dart';
import 'package:get/get.dart';
import '../controllers/grupbelajar_controller.dart';

class GrupbelajarView extends GetView<GrupbelajarController> {
  final controller = Get.put(GrupbelajarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18,),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Grup Belajar",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
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

          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.grupList.length,
                itemBuilder: (context, index) {
                  final item = controller.grupList[index];
                  
                  return InkWell(
                    onTap: () {
                      Get.to(ChatView());   // pindah halaman detail
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xffDFFFE8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          // Foto grup
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(item["foto"]!),
                          ),

                          const SizedBox(width: 10),

                          // Nama grup
                          Expanded(
                            child: Text(
                              item["nama"]!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          // ICON MORE
                          GestureDetector(
                            onTap: () {
                              _showMoreMenu(context, index);
                            },
                            child: const Icon(Icons.more_vert, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),

      // Floating Button Tambah
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffDFFFE8),
        child: const Icon(Icons.add, color: Colors.black, size: 18,),
        onPressed: () {
          TambahgrupPopup.show();
        },
      ),
    );
  }

  void _showMoreMenu(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text("Edit Grup"),
                onTap: () {
                  EditgrupPopup.show();   // Aksi edit
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Hapus Grup"),
                onTap: () {
                  showDeleteDialog(index);// Aksi hapus
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showDeleteDialog(int index) {
    Get.defaultDialog(
      title: "Hapus Tugas?",
      middleText: "Apakah kamu yakin ingin menghapus tugas ini?",
      textCancel: "Batal",
      textConfirm: "Hapus",
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.deleteGrup(index);
        Get.back();
      },
    );
  }

}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: GrupbelajarView(),
  ));
}


