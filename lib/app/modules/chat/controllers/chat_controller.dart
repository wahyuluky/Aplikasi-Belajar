import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/app/modules/chat/controllers/chat_message.dart';
import 'dart:convert';


class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var messages = <ChatMessage>[].obs;
  var groupName = "".obs;
  var groupImage = "".obs;

  // Mode edit
  RxBool isEditMode = false.obs;
  RxInt editingIndex = (-1).obs;
  RxBool isTyping = false.obs;
  RxString typingText = "".obs;
  RxBool isEditing = false.obs; // khusus edit pesan


  RxString editingMessageId = "".obs;
  String get currentUserId => _auth.currentUser!.uid;

  // Avatar contoh (ganti sesuai kebutuhan)
  final userAvatar =
      "https://i.pravatar.cc/150?img=32"; // avatar user
  final otherAvatar =
      "https://i.pravatar.cc/150?img=15"; // avatar lawan bicara



  void onTyping(String text) {
   isTyping.value = text.trim().isNotEmpty;
  }

  Future fixOldMessages(String groupId) async {
    final snap = await _firestore
        .collection('grup_belajar')
        .doc(groupId)
        .collection('chat')
        .get();

    for (var doc in snap.docs) {
      final data = doc.data();

      if (data['senderName'] == 'username') {
        final senderId = data['senderId'];

        final userDoc =
            await _firestore.collection('users').doc(senderId).get();

        final realName =
            userDoc.exists ? userDoc['username'] : 'User';

        await doc.reference.update({
          'senderName': realName,
        });
      }
    }
  }




  // ============================================================
  // LOAD INFO GRUP
  // ============================================================
  Future<void> loadGroupInfo(String groupId) async {
    final doc = await FirebaseFirestore.instance
        .collection('grup_belajar')
        .doc(groupId)
        .get();

    if (doc.exists) {
      groupName.value = doc.data()?['nama'] ?? 'grup belajar';
    } else {
      groupName.value = 'nama_grup';
    }
    groupImage.value = doc.data()?['foto'] ?? 'fotourl';
  }


  // ============================================================
  // LOAD CHAT REALTIME
  // ============================================================
  void loadMessages(String groupId) {
    _firestore
        .collection('grup_belajar')
        .doc(groupId)
        .collection('chat')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .listen((snap) {
      messages.value = snap.docs.map((d) {
        final data = d.data();

        return ChatMessage(
          id: d.id,
          message: data.containsKey('text') ? data['text'] : null,
          senderId: data['senderId'],
          senderName: data['senderName'] ?? 'User',
          isMe: data['senderId'] == currentUserId,
          avatar: data['senderAvatar'],
          createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
          type: data.containsKey('type') ? data['type'] : 'text',
          imageBase64: data.containsKey('imageBase64')
            ? data['imageBase64']
            : null,
        );
      }).toList();
    });
  }

  Future<String> _getUsername() async {
    final uid = currentUserId;
    final doc = await _firestore.collection('users').doc(uid).get();

    if (doc.exists && doc.data()!.containsKey('username')) {
      return doc['username'];
    }
    return 'User';
  }



  // ============================================================
  // KIRIM PESAN BARU
  // ============================================================
  Future sendMessage(String groupId, String text) async {
    if (text.trim().isEmpty) return;

    final username = await _getUsername();

    await _firestore
        .collection('grup_belajar')
        .doc(groupId)
        .collection('chat')
        .add({
      'type': 'text',
      'text': text,
      'senderId': currentUserId,
      'senderName': username,
      'senderAvatar': _auth.currentUser!.photoURL ??
          "https://i.pravatar.cc/150?img=32",
      'createdAt': FieldValue.serverTimestamp(),
    });
  }


  // ============================================================
  // EDIT PESAN
  // ============================================================
  void startEdit(String messageId, String oldMessage) {
    isEditing.value = true;
    editingMessageId.value = messageId;
  }

  Future updateMessage(String groupId, String newText) async {
    if (editingMessageId.value.isEmpty) return;

    await _firestore
        .collection('grup_belajar')
        .doc(groupId)
        .collection('chat')
        .doc(editingMessageId.value)
        .update({
      'text': newText,
    });

    isEditMode.value = false;
    editingMessageId.value = "";
  }

  // ============================================================
  // HAPUS PESAN
  // ============================================================
  Future deleteMessage(String groupId, String messageId) async {
    await _firestore
        .collection('grup_belajar')
        .doc(groupId)
        .collection('chat')
        .doc(messageId)
        .delete();
  }

  // ============================================================
  // PICK IMAGE / FILE (opsional upload)
  // ============================================================
  Future pickImageFromCamera(String groupId) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );

    if (image == null) return;

    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    await _firestore
        .collection('grup_belajar')
        .doc(groupId)
        .collection('chat')
        .add({
      'type': 'image',
      'imageBase64': base64Image,
      'senderId': currentUserId,
      'senderAvatar': _auth.currentUser!.photoURL ??
          "https://i.pravatar.cc/150?img=32",
      'createdAt': FieldValue.serverTimestamp(),
    });
  }




  Future pickImageFromGallery(String groupId) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25, // KOMPRES WAJIB
      maxWidth: 720,
    );

    if (image == null) return;

    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    await _firestore
        .collection('grup_belajar')
        .doc(groupId)
        .collection('chat')
        .add({
      'type': 'image',
      'imageBase64': base64Image,
      'senderId': currentUserId,
      'senderAvatar': _auth.currentUser!.photoURL ??
          "https://i.pravatar.cc/150?img=32",
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

}
