enum MessageType {
  text,
  image,
  document,
  voice,
}

class ChatMessage {
  String message;
  bool isMe;
  String avatar;

  MessageType type;
  String? filePath; // untuk foto/dokumen/audio

  DateTime time;

  ChatMessage({
    required this.message,
    required this.isMe,
    required this.avatar,
    required this.type,
    this.filePath,
    DateTime? time,
  }) : time = time ?? DateTime.now();
}
