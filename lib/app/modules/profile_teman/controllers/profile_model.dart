class ProfileModel {
  final String name;
  final String phone;
  final String avatar;

  ProfileModel({
    required this.name,
    required this.phone,
    required this.avatar,
  });

  factory ProfileModel.fromFirestore(Map<String, dynamic> data) {
    return ProfileModel(
      name: data['username'] ?? '-',
      phone: data['phone'] ?? '-',
      avatar: data['foto'] ?? 'https://picsum.photos/200',
    );
  }

  ProfileModel copyWith({
    String? name,
    String? phone,
    String? avatar,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
    );
  }
}
