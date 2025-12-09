import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  var selectedIndex = 0.obs;
  var photoPath = "".obs;
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // Data profile reactive (aman walaupun kosong)
  var email = "".obs;
  var phone = "".obs;
  var address = "".obs;
  var birthDate = "".obs;
  var photo = "".obs;

  var isLoading = true.obs;

  // Controller untuk form edit
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final addressC = TextEditingController();
  final birthDateC = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
    _loadProfileedit();
  }

  // ---------------------------------------------------------
  // LOAD PROFILE DARI FIRESTORE
  // ---------------------------------------------------------
  Future<void> _loadProfileedit() async {
    final uid = _auth.currentUser!.uid;

    final doc = await _firestore.collection("users").doc(uid).get();

    if (doc.exists) {
      emailC.text    = doc["email"];
      phoneC.text    = doc["phone"];
      addressC.text  = doc["address"];
      birthDateC.text = doc["birthDate"];
      photo.value = doc["photo"] ?? "";

      emailC.text = email.value;
      phoneC.text = phone.value;
      addressC.text = address.value;
      birthDateC.text = birthDate.value;
    }
    isLoading.value = false;
  }

  Future<void> _loadProfile() async {
  final uid = _auth.currentUser!.uid;

  final doc = await _firestore.collection("users").doc(uid).get();

  if (doc.exists) {
    // Set Rx value (dipakai untuk ProfileView)
    email.value     = doc["email"] ?? "";
    phone.value     = doc["phone"] ?? "";
    address.value   = doc["address"] ?? "";
    birthDate.value = doc["birthDate"] ?? "";
    photo.value     = doc["photo"] ?? "";

    // Set ke TextController (dipakai untuk EditProfileView)
    emailC.text     = email.value;
    phoneC.text     = phone.value;
    addressC.text   = address.value;
    birthDateC.text = birthDate.value;
  }

  isLoading.value = false;
}



  // ---------------------------------------------------------
  // UPDATE PROFILE KE FIRESTORE
  // ---------------------------------------------------------
  Future<void> updateProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _firestore.collection("users").doc(uid).update({
      "email": emailC.text.trim(),
      "phone": phoneC.text.trim(),
      "address": addressC.text.trim(),
      "birthDate": birthDateC.text.trim(),
      "photo": photo.value,
    });
    //perbarui nilai Rx agar UI terupdate
    email.value = emailC.text;
    phone.value = phoneC.text;
    address.value = addressC.text;
    birthDate.value = birthDateC.text;

    Get.back();
    Get.snackbar("Berhasil", "Profil diperbarui",
    snackPosition: SnackPosition.TOP
    );
  }

  void logout() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Apakah kamu yakin ingin logout?",
      textCancel: "Batal",
      textConfirm: "Logout",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.offAllNamed("/login"); 
      },
    );
  }

  // ---------------------------------------------------------
  // UPDATE FOTO
  // ---------------------------------------------------------
  Future<void> updatePhoto(String imagePath) async {
    photo.value = imagePath; // jika mau upload ke storage, aku bisa buatkan

    final uid = _auth.currentUser!.uid;

    await _firestore.collection("users").doc(uid)
        .set({"photo": imagePath}, SetOptions(merge: true));
  }

  @override
  void onClose() {
    emailC.dispose();
    phoneC.dispose();
    addressC.dispose();
    birthDateC.dispose();
    super.onClose();
  }

}
