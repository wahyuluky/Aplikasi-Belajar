import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/grupbelajar_controller.dart';
import '../../chat/views/chat_view.dart';
import 'editgrup_popup.dart';
import 'tambahgrup_popup.dart';

class GrupbelajarView extends GetView<GrupbelajarController> {
  final controller = Get.put(GrupbelajarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
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

      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: controller.grupList.length,
          itemBuilder: (context, index) {
            final item = controller.grupList[index];

            return InkWell(
              onTap: () {
                Get.to(() => ChatView(
                      groupId: index.toString(),
                      groupName: item["nama"]!,
                ));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xffDFFFE8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    CircleAvatar(radius: 22, backgroundImage: NetworkImage(item["foto"]!)),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        item["nama"]!,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),

                    GestureDetector(
                      onTap: () => _showMoreMenu(context, index),
                      child: const Icon(Icons.more_vert, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffDFFFE8),
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () => TambahgrupPopup.show(),
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
                  Navigator.pop(context);
                  EditgrupPopup.show(index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Hapus Grup"),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteDialog(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteDialog(int index) {
    Get.defaultDialog(
      title: "",
      content: Column(
        children: const [
          Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 60),
          SizedBox(height: 10),
          Text("Apakah Anda yakin?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text("ingin menghapus grup ini!", style: TextStyle(fontSize: 14)),
        ],
      ),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () => Get.back(),
        child: const Text("Tidak"),
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: () {
          controller.deleteGrup(index);
          Get.back();
        },
        child: const Text("Iya"),
      ),
    );
  }
}
