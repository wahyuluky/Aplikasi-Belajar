import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/chat/views/chat_view.dart';
import 'package:flutter_application_1/app/modules/grupbelajar/views/editgrup_popup.dart';
import 'package:flutter_application_1/app/modules/grupbelajar/views/tambahgrup_popup.dart';
import '../controllers/grupbelajar_controller.dart';

class GrupbelajarView extends GetView<GrupbelajarController> {
  @override
  final controller = Get.put(GrupbelajarController());

  GrupbelajarView({super.key});
  

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
                      print("GROUP ID DIKIRIM: ${item['id']}");
                      Get.to(ChatView(groupId: item['id'],));   // pindah halaman detail
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
                              _showMoreMenu(context, item);
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

  void _showMoreMenu(BuildContext context, Map<String, dynamic> item) {
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
                  Get.back(); // tutup bottom sheet dulu
                  EditgrupPopup.show(
                    id: item['id'],
                    nama: item['nama'],
                    foto: item['foto'],
                  );
                }
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Hapus Grup"),
                onTap: () {
                  Get.back();
                  showDeleteDialog(item['id']);// Aksi hapus
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.orange),
                title: const Text("Keluar dari Grup"),
                onTap: () {
                  Get.back();
                  showLeaveGroupDialog(item['id']);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showLeaveGroupDialog(String grupId) {
    Get.defaultDialog(
      title: "",
      backgroundColor: Colors.white,
      radius: 20,
      content: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.orange.shade100,
            child: const Icon(Icons.exit_to_app, color: Colors.orange, size: 32),
          ),
          const SizedBox(height: 15),
          const Text(
            "Keluar dari Grup?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Anda akan keluar dari grup ini, namun grup tetap tersedia untuk anggota lain.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text("Batal", style: TextStyle(color: Colors.black),),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    controller.leaveGroup(grupId);
                    Get.back();
                  },
                  child: const Text("Keluar", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  void showDeleteDialog(String docId) {
    Get.defaultDialog(
      title: "",
      backgroundColor: Colors.white,
      radius: 20,
      content: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.red.shade100,
            child: const Icon(
              Icons.delete_forever,
              color: Colors.red,
              size: 32,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Hapus Grup?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Tindakan ini tidak dapat dibatalkan.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text("Batal", style: TextStyle(color: Colors.black),),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    controller.deleteGrup(docId);
                    Get.back();
                    Get.snackbar(
                      "Sukses",
                      "Grup berhasil dihapus",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.TOP,
                    );
                  },
                  child: const Text("Hapus", style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}



