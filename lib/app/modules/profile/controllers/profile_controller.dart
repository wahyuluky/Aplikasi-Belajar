import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {

    var selectedIndex = 0.obs;
    var photoPath = "".obs;
    void changeTab(int index) {
      selectedIndex.value = index;
    }

  var email = "Nabila@gmail.com".obs;
  var phone = "+62. 000 000 000 000".obs;
  var address = "JL. melati No. 123, jakarta".obs;
  var birthDate = "8 Agustus 2004".obs;

  // Controller untuk form edit
  late TextEditingController emailC;
  late TextEditingController phoneC;
  late TextEditingController addressC;
  late TextEditingController birthDateC;

  @override
  void onInit() {
    emailC = TextEditingController(text: email.value);
    phoneC = TextEditingController(text: phone.value);
    addressC = TextEditingController(text: address.value);
    birthDateC = TextEditingController(text: birthDate.value);
    super.onInit();
  }

  void updateProfile() {
    email.value = emailC.text;
    phone.value = phoneC.text;
    address.value = addressC.text;
    birthDate.value = birthDateC.text;

    Get.back(); // kembali ke halaman profile
    Get.snackbar("Berhasil", "Profil berhasil diperbarui");
  }

  void logout() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Apakah kamu yakin ingin logout?",
      textCancel: "Batal",
      textConfirm: "Logout",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(); 
        Get.offAllNamed("/login"); 
      },
    );
  }
  void updatePhoto(String path) {
  photoPath.value = path;   // RxString
  // simpan ke Firestore atau server jika perlu
}

}
