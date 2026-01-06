import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseFriendController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  RxList<Map<String, dynamic>> friends = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> allFriends = [];

   // jumlah lagu dipilih
  RxInt selectedCount = 0.obs;

  // SEARCH
  final searchC = TextEditingController();

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
    super.onInit();
  }

  /// LOAD SEMUA USER
  void loadUsers() {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;
    
    _firestore.collection('users').snapshots().listen((snapshot) {
      final data = snapshot.docs
        .where((doc) => doc.id != currentUid) // ⬅️ EXCLUDE USER LOGIN
        .map((doc) {
        final d = doc.data();
        return {
          'uid': doc.id,
          'username': d['username'],
          "photo": d["photo"] ?? "",
        };
      }).toList();

      allFriends = data;           // ✅ SIMPAN DATA ASLI
      friends.assignAll(data);     // ✅ DATA TAMPIL DI UI

      // friends.assignAll(allFriends);
      selected.assignAll(List.generate(friends.length, (_) => false));
      selectedCount.value = 0;
    });
  }

  /// SEARCH FILTER
  void searchFriend(String keyword) {
    if (keyword.isEmpty) {
      friends.assignAll(allFriends);
    } else {
      friends.assignAll(
        allFriends.where((f) =>
            f['username']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase())),
      );
    }
    selected.assignAll(List.generate(friends.length, (_) => false));
    selectedCount.value = 0;
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
      snackPosition: SnackPosition.TOP,
    );
    // ⬅️ KEMBALI
    Future.delayed(const Duration(milliseconds: 800), () {
      Get.back();
    });
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
