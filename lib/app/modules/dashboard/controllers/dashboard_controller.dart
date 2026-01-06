import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/modules/tugas/controllers/tugas_model.dart';

class DashboardController extends GetxController {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  StreamSubscription<User?>? _authSub;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _tugasSub;
  StreamSubscription? _studySub;

  // ===============================
  // STATE
  // ===============================
  var upcomingTasks = <TugasModel>[].obs;
  var postponedTasks = <TugasModel>[].obs;

  var totalMendatang = 0.obs;
  var totalDitunda = 0.obs;

  // ===============================
  // DATA LAIN
  // ===============================
  var studyFocusTitle = 'Belajar'.obs;
  var studyHoursCompleted = 0.obs;
  final int studyHoursTarget = 4;

  var productivityDateRange = '19 - 25 Okt 2025'.obs;
  var studyHoursPerDay = 3.5.obs;
  var tasksCompletedPercent = 50.obs;

  @override
  void onInit() {
    super.onInit();

    // 🔥 AUTH SAFE UNTUK WEB
    _authSub = _auth.authStateChanges().listen((user) {
      if (user != null) {
        _listenDashboardTugas(user.uid);
        _listenStudySessions(user.uid); // ⬅️ TAMBAHKAN
        _setDateRange(); 
      } else {
        _clearData();
      }
    });

  }

  // ===============================
  // FIRESTORE LISTENER
  // ===============================
  void _listenDashboardTugas(String uid) {
    _tugasSub?.cancel();

    _tugasSub = _db
        .collection("users")
        .doc(uid)
        .collection("tugas")
        .orderBy("tanggal")
        .snapshots()
        .listen((snapshot) {
      final all = snapshot.docs
          .map((d) => TugasModel.fromMap(d.id, d.data()))
          .toList();

      _olahTugas(all);
      _hitungProduktivitasTugas(all);
    });
  }

  void _olahTugas(List<TugasModel> all) {
     _hitungProduktivitasTugas(all);

    final aktif = all.where((t) => !t.isDone).toList();
    final ditunda = all.where((t) => t.isDone).toList();

    totalMendatang.value = aktif.length;
    totalDitunda.value = ditunda.length;

    aktif.sort((a, b) => a.tanggal.compareTo(b.tanggal));
    ditunda.sort((a, b) => b.tanggal.compareTo(a.tanggal));

    upcomingTasks.value = aktif.take(3).toList();
    postponedTasks.value = ditunda.take(3).toList();
  }

  String formatTanggal(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year}";
  }

  void _listenStudySessions(String uid) {
    final start = DateTime.now().subtract(const Duration(days: 7));

    _studySub = _db
        .collection("users")
        .doc(uid)
        .collection("study_sessions")
        .where("date", isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .snapshots()
        .listen((snapshot) {
      final totalMenit = snapshot.docs.fold<int>(
        0,
        (sum, d) => sum + (d["duration"] as int),
      );

      studyHoursPerDay.value =
      ((totalMenit / 60 / 7) * 10).roundToDouble() / 10;
    });
  }

  void _setDateRange() {
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 6));

    productivityDateRange.value =
        "${start.day}/${start.month} - ${now.day}/${now.month}";
  }

  Future<void> startLearningSession() async {
    final uid = _auth.currentUser!.uid;

    await _db
        .collection("users")
        .doc(uid)
        .collection("study_sessions")
        .add({
      "date": Timestamp.now(),
      "duration": 60, // contoh 1 jam
    });
  }

  void _clearData() {
    upcomingTasks.clear();
    postponedTasks.clear();
    totalMendatang.value = 0;
    totalDitunda.value = 0;
  }

  void _hitungProduktivitasTugas(List<TugasModel> all) {
    if (all.isEmpty) {
      tasksCompletedPercent.value = 0;
      return;
    }

    final selesai = all.where((t) => t.isDone).length;
    tasksCompletedPercent.value =
        ((selesai / all.length) * 100).round();
  }


  @override
  void onClose() {
    _authSub?.cancel();
    _tugasSub?.cancel();
    _studySub?.cancel(); // ⬅️ TAMBAHKAN
    super.onClose();
  }

  // ===============================
  // UI ACTION
  // ===============================
  void startLearning() {
    if (studyHoursCompleted.value < studyHoursTarget) {
      studyHoursCompleted.value++;
    }
  }
}
