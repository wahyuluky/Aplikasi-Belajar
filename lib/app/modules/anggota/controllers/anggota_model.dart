class AnggotaModel {
  final String uid;
  final String username;
  final String fotoUrl;
  final String role;
  final DateTime joinedAt;

  AnggotaModel({
    required this.uid,
    required this.username,
    required this.fotoUrl,
    required this.role,
    required this.joinedAt,
  });
}
