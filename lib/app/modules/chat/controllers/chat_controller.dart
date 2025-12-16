import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/app/modules/chat/controllers/chat_message.dart';

class ChatController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // ================= STATE =================
  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  RxString groupName = "".obs;

  RxBool isTyping = false.obs;
  RxBool isEditing = false.obs;
  RxBool isEditMode = false.obs;

  RxString editingMessageId = "".obs;

  String get uid => auth.currentUser!.uid;

  // ================= GROUP INFO =================
  Future<void> loadGroupInfo(String groupId) async {
    final doc = await firestore.collection("grup_belajar").doc(groupId).get();
    groupName.value = doc.data()?["nama"] ?? "Grup";
  }

  // ================= LOAD CHAT REALTIME =================
  void loadMessages(String groupId) {
    firestore
        .collection("grup_belajar")
        .doc(groupId)
        .collection("chat")
        .orderBy("createdAt")
        .snapshots()
        .listen((snap) {
      messages.value = snap.docs.map((d) {
        final data = d.data();

        return ChatMessage(
          id: d.id,
          message: data["text"],
          senderId: data["senderId"],
          avatar: data["senderAvatar"] ??
              "https://i.pravatar.cc/150?img=32",
          isMe: data["senderId"] == uid,
          type: MessageType.values.firstWhere(
            (e) => e.name == (data["type"] ?? "text"),
            orElse: () => MessageType.text,
          ),
          imageBase64: data["imageBase64"],
          createdAt:
              (data["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
        );
      }).toList();
    });
  }

  // ================= TYPING =================
  void onTyping(String text) {
    isTyping.value = text.trim().isNotEmpty;
  }

  // ================= SEND TEXT =================
  Future<void> sendMessage(String groupId, String text) async {
    if (text.trim().isEmpty) return;

    await firestore
        .collection("grup_belajar")
        .doc(groupId)
        .collection("chat")
        .add({
      "type": MessageType.text.name,
      "text": text.trim(),
      "senderId": uid,
      "senderAvatar":
          auth.currentUser!.photoURL ?? "https://i.pravatar.cc/150?img=32",
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  // ================= IMAGE CAMERA =================
  Future<void> pickImageFromCamera(String groupId) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 35,
    );
    if (image == null) return;

    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    await firestore
        .collection("grup_belajar")
        .doc(groupId)
        .collection("chat")
        .add({
      "type": MessageType.image.name,
      "imageBase64": base64Image,
      "senderId": uid,
      "senderAvatar":
          auth.currentUser!.photoURL ?? "https://i.pravatar.cc/150?img=32",
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  // ================= IMAGE GALLERY =================
  Future<void> pickImageFromGallery(String groupId) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
      maxWidth: 720,
    );
    if (image == null) return;

    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    await firestore
        .collection("grup_belajar")
        .doc(groupId)
        .collection("chat")
        .add({
      "type": MessageType.image.name,
      "imageBase64": base64Image,
      "senderId": uid,
      "senderAvatar":
          auth.currentUser!.photoURL ?? "https://i.pravatar.cc/150?img=32",
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  // ================= EDIT MESSAGE =================
  void startEdit(String messageId, String oldText) {
    isEditing.value = true;
    isEditMode.value = true;
    editingMessageId.value = messageId;
  }

  Future<void> updateMessage(String groupId, String newText) async {
    if (editingMessageId.value.isEmpty) return;

    await firestore
        .collection("grup_belajar")
        .doc(groupId)
        .collection("chat")
        .doc(editingMessageId.value)
        .update({
      "text": newText,
    });

    isEditing.value = false;
    isEditMode.value = false;
    editingMessageId.value = "";
  }

  // ================= DELETE =================
  Future<void> deleteMessage(String groupId, String messageId) async {
    await firestore
        .collection("grup_belajar")
        .doc(groupId)
        .collection("chat")
        .doc(messageId)
        .delete();
  }
}
