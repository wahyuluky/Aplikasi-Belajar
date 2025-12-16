import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/modules/chat/controllers/chat_message.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:flutter_application_1/app/data/auth_service.dart';


class ChatController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  RxString groupName = "".obs;

  String get uid => auth.currentUser!.uid;

  void loadGroupInfo(String groupId) async {
    final doc =
        await firestore.collection("grup_belajar").doc(groupId).get();
    groupName.value = doc["nama"];
  }

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
        senderId: data["senderId"],
        avatar: data["senderAvatar"],
        type: MessageType.values.firstWhere(
          (e) => e.name == data["type"],
          orElse: () => MessageType.text,
        ),
        message: data["text"],
        imageBase64: data["imageBase64"],
        createdAt: (data["createdAt"] as Timestamp?)?.toDate() 
            ?? DateTime.now(),
        isMe: data["senderId"] == uid,
      );
    }).toList();
  });
}


Future<void> sendText(String groupId, String text) async {
  if (text.trim().isEmpty) return;

  final user = await AuthService.to.getCurrentUser();

  await firestore
      .collection("grup_belajar")
      .doc(groupId)
      .collection("chat")
      .add({
    "type": MessageType.text.name,
    "text": text,
    "senderId": uid,
    "senderName": user?["name"],
    "senderAvatar": user?["photo"],
    "createdAt": FieldValue.serverTimestamp(),
  });
}

}
