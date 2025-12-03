import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/app/modules/chat/controllers/chat_message.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  var messages = <ChatMessage>[].obs;

  // Mode edit
  RxBool isEditMode = false.obs;
  RxInt editingIndex = (-1).obs;
  var isTyping = false.obs;


  // Avatar contoh (ganti sesuai kebutuhan)
  final userAvatar =
      "https://i.pravatar.cc/150?img=32"; // avatar user
  final otherAvatar =
      "https://i.pravatar.cc/150?img=15"; // avatar lawan bicara

  void onTyping(String text) {
    isTyping.value = text.trim().isNotEmpty;
  }


  // Kirim pesan baru
  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    if (isEditMode.value) {
      messages[editingIndex.value].message = text;
      messages.refresh();

      isEditMode.value = false;
      editingIndex.value = -1;
    } else {
      messages.add(
        ChatMessage(
          message: text,
          isMe: true,
          avatar: userAvatar,
        ),
      );

      // Bot atau teman membalas otomatis
      _autoReply();
    }
  }

  // Edit mode
  void startEdit(int index) {
    isEditMode.value = true;
    editingIndex.value = index;
  }

  // Hapus pesan
  void deleteMessage(int index) {
    messages.removeAt(index);
  }

  // Simulasi balasan otomatis
  void _autoReply() {
    Future.delayed(const Duration(milliseconds: 600), () {
      messages.add(ChatMessage(
        message: "Pesan kamu sudah aku terima 😊",
        isMe: false,
        avatar: otherAvatar,
      ));
    });
  }

  Future pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      messages.add(ChatMessage(
        message: "[Foto terkirim]",
        avatar: "...",
        isMe: true,
      ));
    }
  }

  Future pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      messages.add(ChatMessage(
        message: "📄 Dokumen: ${result.files.single.name}",
        avatar: "...",
        isMe: true,
      ));
    }
  }
}
