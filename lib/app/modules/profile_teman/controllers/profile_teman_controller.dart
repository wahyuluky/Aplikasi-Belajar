import 'package:flutter_application_1/app/modules/profile_teman/controllers/profile_model.dart';
import 'package:get/get.dart';

class ProfileTemanController extends GetxController {
Rx<ProfileModel> profile = ProfileModel(
    name: "Jauza Wijdaniah",
    phone: "+62 123 456 789",
    avatar: "assets/user5.jpg",
  ).obs;

  void updateAvatar(String newAvatar) {
    profile.value = profile.value.copyWith(avatar: newAvatar);
  }

  void updateProfile({String? name, String? phone}) {
    profile.value = profile.value.copyWith(name: name, phone: phone);
  }
}
