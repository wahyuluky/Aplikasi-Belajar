enum MessageType {
  text,
  image,
  document,
}

class ChatMessage {
  final String id;
  final String senderId;
  final String avatar;
  final bool isMe;
  final MessageType type;
  final DateTime createdAt;

  final String? message;
  final String? imageBase64;
  final String? fileUrl;
  final String? fileName;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.avatar,
    required this.isMe,
    required this.type,
    required this.createdAt,
    this.message,
    this.imageBase64,
    this.fileUrl,
    this.fileName,
  });
}
