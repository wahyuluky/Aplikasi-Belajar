enum MessageType { 
  text, 
  image, 
  document 
}

class ChatMessage {
  final String id;
  final String senderId;
  final String avatar;
  final MessageType type;
  final String? message;
  final String? imageBase64;
  final DateTime createdAt;
  final bool isMe;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.avatar,
    required this.type,
    this.message,
    this.imageBase64,
    required this.createdAt,
    required this.isMe,
  });
}
