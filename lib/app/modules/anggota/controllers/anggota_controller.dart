import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/anggota/controllers/anggota_model.dart';
import 'package:get/get.dart';

class AnggotaController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var groupName = "".obs;

  RxList<AnggotaModel> anggotaList = <AnggotaModel>[].obs;

  // foto default
  RxString defaultFotoUrl = "https://i.pravatar.cc/150?img=32".obs;

  /// LOAD INFO GRUP
  Future<void> loadGroupInfo(String groupId) async {
    final doc = await FirebaseFirestore.instance
        .collection('grup_belajar')
        .doc(groupId)
        .get();

    if (doc.exists) {
      groupName.value = doc.data()?['nama'] ?? 'Grup Belajar';
    } else {
      groupName.value = 'Grup Belajar';
    }
  }

 /// LOAD MEMBER GRUP (REAL-TIME)
  void loadMembers(String groupId) {
    _firestore
        .collection('grup_belajar')
        .doc(groupId)
        .collection('members')
        .snapshots()
        .listen((memberSnap) async {
      final List<AnggotaModel> temp = [];

      for (final memberDoc in memberSnap.docs) {
        final memberData = memberDoc.data();

        // Ambil data user
        final userDoc = await _firestore
            .collection('users')
            .doc(memberDoc.id)
            .get();

        final userData = userDoc.data();

        temp.add(
          AnggotaModel(
            uid: memberDoc.id,
            username: userData?['username'] ?? 'Unknown User',
            fotoUrl: userData?['fotoUrl'] ??
                "https://i.pravatar.cc/150?img=32=${memberDoc.id.hashCode}",
            role: memberData['role'] ?? 'member',
            joinedAt:
                (memberData['joinedAt'] as Timestamp?)?.toDate() ??
                    DateTime.now(),
          ),
        );
      }

      anggotaList.value = temp;
    });
  }

    Future<void> leaveGroup(String groupId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final firestore = FirebaseFirestore.instance;

    final batch = firestore.batch();

    // 1️⃣ Hapus dari members grup
    final memberRef = firestore
        .collection('grup_belajar')
        .doc(groupId)
        .collection('members')
        .doc(userId);

    batch.delete(memberRef);

    // 2️⃣ Hapus dari joined_groups user
    final joinedGroupRef = firestore
        .collection('users')
        .doc(userId)
        .collection('joined_groups')
        .doc(groupId);

    batch.delete(joinedGroupRef);

    await batch.commit();

    Get.snackbar(
      "Keluar Grup",
      "Kamu telah keluar dari grup",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );

    Get.back();
  }

}
