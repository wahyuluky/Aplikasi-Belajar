class ProfileModel {
  final String name;
  final String phone;
  final String avatar; // path asset / url

  ProfileModel({
    required this.name,
    required this.phone,
    required this.avatar,
  });

  ProfileModel copyWith({String? name, String? phone, String? avatar}) {
    return ProfileModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
    );
  }
}
