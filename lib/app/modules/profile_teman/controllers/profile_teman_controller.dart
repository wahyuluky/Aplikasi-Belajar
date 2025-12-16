import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/profile_teman/controllers/profile_model.dart';

class ProfileTemanController extends GetxController {
Rx<ProfileModel?> profile = Rx<ProfileModel?>(null);

  Future<void> loadUser(String userId) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (doc.exists && doc.data() != null) {
      profile.value = ProfileModel.fromFirestore(doc.data()!);
    }
  }

}
