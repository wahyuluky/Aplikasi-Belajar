class ChatMessage {
  final String id;
  final String? message;
  final bool isMe;
  final String senderId;
  final String senderName; // ⬅ TAMBAH
  final String avatar;
  final DateTime? createdAt;
  final String? imageBase64;
  final String type; // "text" | "image"

  ChatMessage({
    required this.id,
    this.message,
    required this.isMe,
    required this.senderId,
    required this.senderName,
    required this.avatar,
    this.createdAt,
    required this.type,
    this.imageBase64,
  });
}
