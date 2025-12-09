import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';
import '../controllers/chat_message.dart';
import '../../materi/views/materi_view.dart';
import '../../anggota/views/anggota_view.dart';

class ChatView extends StatelessWidget {
  final String groupId;
  final String groupName;

  ChatView({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  final ChatController controller = Get.put(ChatController());
  final TextEditingController textController = TextEditingController();

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
          Expanded(child: _chatList()),
          _inputField(),
        ],
      ),
    );
  }

  // === APPBAR ===
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
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
        onPressed: () => Get.back(),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Icon(Icons.people_alt_rounded, size: 18, color: Colors.white),
        ),
      ],
      elevation: 0,
    );
  }

  // === TAB ATAS ===
  Widget _buildTabs() {
    return Container(
      color: const Color(0xffF8F8F8),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _tabItem("DISKUSI", true, () {}),
          _tabItem("MATERI", false, () {
            Get.to(() => MateriView(
                  groupId: groupId,
                  groupName: groupName,
                ));
          }),
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

  // === LIST CHAT ===
  Widget _chatList() {
    return Obx(() {
      final msgs = controller.getMessages(groupId);
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: msgs.length,
        itemBuilder: (context, index) {
          final msg = msgs[index];

          return GestureDetector(
            onLongPress: () => _showOptions(context, index),
            child: Row(
              mainAxisAlignment:
                  msg.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (!msg.isMe)
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(msg.avatar),
                  ),
                if (!msg.isMe) const SizedBox(width: 8),

                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  constraints: BoxConstraints(
                    maxWidth: Get.width * 0.65,
                  ),
                  decoration: BoxDecoration(
                    color: msg.isMe
                        ? Colors.green.shade100
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: _buildMessageContent(msg),
                ),

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
      );
    });
  }

  Widget _buildMessageContent(ChatMessage msg) {
    switch (msg.type) {
      case MessageType.image:
        if (msg.filePath != null && File(msg.filePath!).existsSync()) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.file(
                File(msg.filePath!),
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 6),
              Text(
                msg.message,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          );
        }
        return Text(msg.message, style: const TextStyle(fontSize: 12));

      case MessageType.document:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.insert_drive_file, size: 18),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                msg.message,
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );

      case MessageType.voice:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.graphic_eq, size: 20),
            SizedBox(width: 6),
            Text(
              "Voice note",
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        );

      case MessageType.text:
      default:
        return Text(
          msg.message,
          style: const TextStyle(fontSize: 12),
        );
    }
  }

  // === INPUT BAWAH ===
  Widget _inputField() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 14),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: _showAttachmentMenu,
          ),

          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 14),
              onChanged: controller.onTyping,
              controller: textController,
              decoration: InputDecoration(
                hintText: "Ketik Pesan",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          Obx(() {
            final isTyping = controller.isTyping.value;
            final isRecording = controller.isRecording.value;

            return CircleAvatar(
              radius: 22,
              backgroundColor:
                  isRecording ? Colors.redAccent : Colors.green.shade300,
              child: IconButton(
                icon: Icon(
                  isTyping
                      ? Icons.send
                      : (isRecording ? Icons.stop : Icons.mic),
                  color: Colors.white,
                ),
                onPressed: () async {
                  if (isTyping) {
                    controller.sendMessage(groupId, textController.text);
                    textController.clear();
                    controller.onTyping("");
                  } else {
                    if (!isRecording) {
                      await controller.startRecording(groupId);
                    } else {
                      await controller.stopRecording(groupId);
                    }
                  }
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  // === MENU LAMPIRAN ===
  void _showAttachmentMenu() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Kamera"),
                onTap: () async {
                  Navigator.pop(Get.context!);
                  await controller.pickImageFromCamera(groupId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Galeri"),
                onTap: () async {
                  Navigator.pop(Get.context!);
                  await controller.pickImage(groupId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.file_copy),
                title: const Text("Dokumen"),
                onTap: () async {
                  Navigator.pop(Get.context!);
                  await controller.pickDocument(groupId);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // === MENU EDIT / HAPUS PESAN ===
  void _showOptions(BuildContext context, int index) {
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
                _showEditDialog(index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Hapus"),
              onTap: () {
                Navigator.pop(context);
                controller.deleteMessage(groupId, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(int index) {
    final msgs = controller.getMessages(groupId);
    final msg = msgs[index];
    final editC = TextEditingController(text: msg.message);

    Get.defaultDialog(
      title: "Edit Pesan",
      content: Column(
        children: [
          TextField(
            controller: editC,
            decoration: const InputDecoration(hintText: "Ubah pesan"),
          ),
        ],
      ),
      textCancel: "Batal",
      textConfirm: "Simpan",
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.editMessage(groupId, index, editC.text);
        Get.back();
      },
    );
  }
}

// Widget tab
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
