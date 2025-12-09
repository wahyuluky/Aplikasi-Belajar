import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/app/modules/chat/controllers/chat_message.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';

class ChatController extends GetxController {
  /// Pesan per grup: key = groupId
  RxMap<String, List<ChatMessage>> groupMessages =
      <String, List<ChatMessage>>{}.obs;

  /// Materi dokumen per grup (untuk tab MATERI)
  RxMap<String, List<MateriFile>> materiFiles =
      <String, List<MateriFile>>{}.obs;

  /// Voice note per grup (kalau mau dipakai nanti)
  RxMap<String, List<VoiceMessage>> voiceNotes =
      <String, List<VoiceMessage>>{}.obs;

  final ImagePicker picker = ImagePicker();

  // Recorder untuk mic
  FlutterSoundRecorder recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  RxBool isRecording = false.obs;

  // Typing/sending
  RxBool isTyping = false.obs;

  final userAvatar = "https://i.pravatar.cc/150?img=32";
  final otherAvatar = "https://i.pravatar.cc/150?img=15";

  @override
  void onInit() {
    super.onInit();
    initRecorder();
  }

  Future<void> initRecorder() async {
    await recorder.openRecorder();
    isRecorderReady = true;
  }

  // ========= Getter List =========

  List<ChatMessage> getMessages(String groupId) {
    groupMessages.putIfAbsent(groupId, () => []);
    return groupMessages[groupId]!;
  }

  List<MateriFile> getMateri(String groupId) {
    materiFiles.putIfAbsent(groupId, () => []);
    return materiFiles[groupId]!;
  }

  List<VoiceMessage> getVoiceNotes(String groupId) {
    voiceNotes.putIfAbsent(groupId, () => []);
    return voiceNotes[groupId]!;
  }

  // ========= Typing =========

  void onTyping(String text) {
    isTyping.value = text.trim().isNotEmpty;
  }

  // ========= Kirim Pesan Text =========

  void sendMessage(String groupId, String text) {
    if (text.trim().isEmpty) return;

    getMessages(groupId).add(
      ChatMessage(
        message: text,
        isMe: true,
        avatar: userAvatar,
        type: MessageType.text,
      ),
    );
    groupMessages.refresh();

    _autoReply(groupId);
  }

  void _autoReply(String groupId) {
    Future.delayed(const Duration(milliseconds: 600), () {
      getMessages(groupId).add(
        ChatMessage(
          message: "Pesan kamu sudah aku terima 😊",
          isMe: false,
          avatar: otherAvatar,
          type: MessageType.text,
        ),
      );
      groupMessages.refresh();
    });
  }

  // ========= Kirim Foto dari Galeri =========

  Future<void> pickImage(String groupId) async {
    final XFile? img =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (img != null) {
      getMessages(groupId).add(
        ChatMessage(
          message: "[Foto terkirim]",
          isMe: true,
          avatar: userAvatar,
          type: MessageType.image,
          filePath: img.path,
        ),
      );
      groupMessages.refresh();
    }
  }

  // ========= Kirim Foto dari Kamera =========

  Future<void> pickImageFromCamera(String groupId) async {
    final XFile? img =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 70);

    if (img != null) {
      getMessages(groupId).add(
        ChatMessage(
          message: "[Foto kamera]",
          isMe: true,
          avatar: userAvatar,
          type: MessageType.image,
          filePath: img.path,
        ),
      );
      groupMessages.refresh();
    }
  }

  // ========= Kirim Dokumen (masuk Tab Materi juga) =========

  Future<void> pickDocument(String groupId) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      final file = MateriFile(
        name: result.files.single.name,
        path: result.files.single.path!,
        uploadedAt: DateTime.now(),
      );

      // Simpan ke materi
      getMateri(groupId).add(file);
      materiFiles.refresh();

      // Tampilkan info file di chat juga
      getMessages(groupId).add(
        ChatMessage(
          message: "📄 ${file.name}",
          isMe: true,
          avatar: userAvatar,
          type: MessageType.document,
          filePath: file.path,
        ),
      );
      groupMessages.refresh();
    }
  }

  // ========= Voice Note (MIC) =========

  Future<void> startRecording(String groupId) async {
    if (!isRecorderReady) return;
    isRecording.value = true;
    await recorder.startRecorder(
      toFile: "voice_${DateTime.now().millisecondsSinceEpoch}.aac",
    );
  }

  Future<void> stopRecording(String groupId) async {
    if (!isRecorderReady) return;
    final String? path = await recorder.stopRecorder();
    isRecording.value = false;

    if (path != null) {
      final voice = VoiceMessage(
        filePath: path,
        duration: const Duration(seconds: 3), // dummy, bisa diambil dari file
      );

      getVoiceNotes(groupId).add(voice);
      voiceNotes.refresh();

      getMessages(groupId).add(
        ChatMessage(
          message: "[Voice Note]",
          isMe: true,
          avatar: userAvatar,
          type: MessageType.voice,
          filePath: path,
        ),
      );
      groupMessages.refresh();
    }
  }

  // ========= Edit & Hapus Pesan =========

  void editMessage(String groupId, int index, String newText) {
    final list = getMessages(groupId);
    if (index < 0 || index >= list.length) return;
    list[index].message = newText;
    list[index].type = MessageType.text;
    groupMessages.refresh();
  }

  void deleteMessage(String groupId, int index) {
    final list = getMessages(groupId);
    if (index < 0 || index >= list.length) return;
    list.removeAt(index);
    groupMessages.refresh();
  }
}

class MateriFile {
  final String name;
  final String path;
  final DateTime uploadedAt;

  MateriFile({
    required this.name,
    required this.path,
    required this.uploadedAt,
  });
}

class VoiceMessage {
  final String filePath;
  final Duration duration;

  VoiceMessage({
    required this.filePath,
    required this.duration,
  });
}
