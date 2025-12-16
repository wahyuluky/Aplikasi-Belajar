import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseFriendController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  RxList<Map<String, dynamic>> friends = <Map<String, dynamic>>[].obs;

   // jumlah lagu dipilih
  RxInt selectedCount = 0.obs;

  late String groupId;

  // list boolean untuk seleksi lagu
  RxList<bool> selected = <bool>[].obs;

  /// INIT dengan groupId
  void init(String gid) {
    groupId = gid;
    loadUsers();
  }

  @override
  void onInit() {
    selected = List.generate(friends.length, (_) => false).obs;
    super.onInit();
  }

  /// LOAD SEMUA USER
  void loadUsers() {
    _firestore.collection('users').snapshots().listen((snapshot) {
      friends.value = snapshot.docs.map((doc) {
        return {
          'uid': doc.id,
          'username': doc['username'],
        };
      }).toList();

      selected.value =
          List.generate(friends.length, (_) => false);
    });
  }

  Future<bool> isUserAlreadyMember(String userId, String groupId) async {
    final doc = await FirebaseFirestore.instance
        .collection('grup_belajar')
        .doc(groupId)
        .collection('members')
        .doc(userId)
        .get();

    return doc.exists;
  }

  /// TAMBAHKAN USER KE GRUP
  Future<void> addSelectedToGroup() async {
    final batch = FirebaseFirestore.instance.batch();
    bool hasDuplicate = false;

    for (int i = 0; i < friends.length; i++) {
      if (!selected[i]) continue;

      final userId = friends[i]['uid'];

      final alreadyMember =
          await isUserAlreadyMember(userId, groupId);

      if (alreadyMember) {
        hasDuplicate = true;
        continue; // SKIP user ini
      }

      // 🔹 1. Tambah ke members
      final memberRef = FirebaseFirestore.instance
          .collection('grup_belajar')
          .doc(groupId)
          .collection('members')
          .doc(userId);

      batch.set(memberRef, {
        'role': 'member',
        'joinedAt': FieldValue.serverTimestamp(),
      });

      // 🔹 2. Tambah ke joined_groups user
      final joinedGroupRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('joined_groups')
          .doc(groupId);

      batch.set(joinedGroupRef, {
        'joinedAt': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();

    Get.snackbar(
      hasDuplicate ? "Sebagian dilewati" : "Berhasil",
      hasDuplicate
          ? "Beberapa user sudah tergabung"
          : "Anggota berhasil ditambahkan",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    Get.back();
  }


  // fungsi memilih Teman
  void toggle(int index) {
      selected[index] = !selected[index];
      selected.refresh();
      selectedCount.value = selected.where((e) => e).length;
  }

  // Update jumlah otomatis
  void updateSelectedCount() {
    selectedCount.value = selected.where((e) => e).length;
  }

   // Wrapper untuk toggle sambil update count
  void toggleAndCount(int index) {
    toggle(index);
    updateSelectedCount();
  }
}
