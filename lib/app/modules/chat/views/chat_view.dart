import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/anggota/views/anggota_view.dart';
import 'package:flutter_application_1/app/modules/chat/controllers/chat_message.dart';
import 'package:flutter_application_1/app/modules/grupbelajar/views/grupbelajar_view.dart';
import 'package:flutter_application_1/app/modules/materi/views/materi_view.dart';
import '../controllers/chat_controller.dart';

class ChatView extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());
  final TextEditingController textController = TextEditingController();

  final String groupId;
  ChatView({required this.groupId});

  @override
  Widget build(BuildContext context) {
    controller.loadGroupInfo(groupId);
    controller.loadMessages(groupId);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _buildAppBar(),
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(child: _chatList()),
          _inputField(),
        ],
      ),
    );
  }

  // 🔹 GRADIENT APPBAR
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
      title: Obx(() => Text(
              controller.groupName.value,
              style: TextStyle(color: Colors.white, fontSize: 16),
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

  // 🔹 TAB DISKUSI – MATERI – ANGGOTA
  Widget _buildTabs() {
    return Container(
      color: const Color(0xffF8F8F8),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _tabItem("DISKUSI", true, () {
            // Halaman ini sendiri, tidak pindah
          }),
          _tabItem("MATERI", false, () {
            Get.to(() => MateriView(groupId: groupId,));
          }),
          _tabItem("ANGGOTA", false, () {
            Get.to(() => AnggotaView(groupId: groupId,));
          }),
        ],
      ),
    );
  }


  // 🔹 LIST CHAT DENGAN FOTO AVATAR
  Widget _chatList() {
    return Obx(() => ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final msg = controller.messages[index];

        return GestureDetector(
          onLongPress: () => _showOptions(context, msg),
          child: Row(
            mainAxisAlignment:
                msg.isMe 
                ? MainAxisAlignment.end 
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Avatar kiri jika bukan kita
              if (!msg.isMe)
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(msg.avatar),
                ),          
              if (!msg.isMe) const SizedBox(width: 8),

              // Bubble pesan
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 6),
                constraints: BoxConstraints(
                  maxWidth: Get.width * 0.65,
                ),
                decoration: BoxDecoration(
                  color: msg.isMe
                      ? const Color.fromARGB(255, 210, 247, 212)
                      : const Color.fromARGB(255, 237, 237, 237),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: msg.type == 'image' && msg.imageBase64 != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      base64Decode(msg.imageBase64!),
                      width: 180,
                      fit: BoxFit.cover,
                    ),
                  )
                : Text(
                    msg.message ?? '',
                    style: const TextStyle(fontSize: 12),
                  ),
              ),

              // Avatar kanan jika kita
              if (msg.isMe) const SizedBox(width: 8),
              if (msg.isMe)
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(msg.avatar),
                ),
            ],
          ),
        );
      },
    ));
  }

  // 🔹 INPUT FIELD BAWAH (kamera + mic)
  Widget _inputField() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 14),
      child: Row(
        children: [
          // Icon attachment / camera
          IconButton(
            icon: const Icon(Icons.attach_file,),
            onPressed: _showAttachmentMenu,
          ),

          Expanded(
            child: TextField(
              style: TextStyle(fontSize: 14),
              onChanged: controller.onTyping,
              controller: textController,
              decoration: InputDecoration(
                hintText: controller.isEditMode.value
                  ? "Edit pesan..."
                  : "Ketik pesan...",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.green.shade300,
            child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                final text = textController.text.trim();
                if (text.isEmpty) return;

                if (controller.isEditing.value) {
                  controller.updateMessage(groupId, textController.text);
                  controller.isEditing.value = false;
                } else if(controller.isTyping.value){
                  controller.sendMessage(groupId, textController.text);
                  // aksi untuk mic (record)
                }
                textController.clear();
              },
            ),
          )
        ],
      ),
    );
  }

  void _showAttachmentMenu() {
  showModalBottomSheet(
    context: Get.context!,
    builder: (_) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text("Camera"),
              onTap: () async {
                Navigator.pop(Get.context!);
                // ambil foto
                controller.pickImageFromCamera(groupId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Foto"),
              onTap: () async {
                Navigator.pop(Get.context!);
                controller.pickImageFromGallery(groupId);
              },
            ),
          ],
        ),
      );
    },
  );
}


  // 🔹 BOTTOMSHEET OPTION EDIT/HAPUS
  void _showOptions(BuildContext context, ChatMessage msg) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit"),
              onTap: () {
                Navigator.pop(context);
                controller.startEdit(msg.id, msg.message ?? '');
                textController.text = msg.message ?? '';
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Hapus"),
              onTap: () {
                Navigator.pop(context);
                controller.deleteMessage(groupId, msg.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

  // 🔹 TAB ITEM
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


