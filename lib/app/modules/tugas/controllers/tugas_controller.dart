/* INI TERHUBUNG KE DATABASE. NOTES SAMA KAYA DI MODEL

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'tugas_model.dart';

class TugasController extends GetxController {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  
  var listTugas = <TugasModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _listenTugas();   // Realtime listener
  }

  // LISTEN DATA REALTIME
  void _listenTugas() {
    String uid = _auth.currentUser!.uid;

    _db
        .collection("users")
        .doc(uid)
        .collection("tugas")
        .orderBy("tanggal")
        .snapshots()
        .listen((snapshot) {
      listTugas.value = snapshot.docs.map((doc) {
        return TugasModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  String formatTanggal(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year}";
  }

  
  // 🔥 TOGGLE CHECKBOX
  Future<void> toggleCheck(TugasModel t) async {
    String uid = _auth.currentUser!.uid;

    await _db
        .collection("users")
        .doc(uid)
        .collection("tugas")
        .doc(t.id)
        .update({
      "isDone": !t.isDone,
    });
  }


  // 🔥 HAPUS TUGAS
  Future<void> hapusTugas(String id) async {
    String uid = _auth.currentUser!.uid;

    await _db
        .collection("users")
        .doc(uid)
        .collection("tugas")
        .doc(id)
        .delete();
  }
}
---------------------------------------------------*/

import 'package:get/get.dart';
import 'tugas_model.dart';

class TugasController extends GetxController {
  var listTugas = <TugasModel>[].obs;

  void tambahTugas(TugasModel tugas) {
    listTugas.add(tugas);
    urutkanTanggal();
  }

  void toggleCheck(TugasModel tugas) {
    tugas.isDone = !tugas.isDone;
    listTugas.refresh();
  }

  void hapusTugas(String id) {
    listTugas.removeWhere((t) => t.id == id);
  }

  String formatTanggal(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  void urutkanTanggal() {
    listTugas.sort((a, b) => a.tanggal.compareTo(b.tanggal));
    listTugas.refresh();
  }
}