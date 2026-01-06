import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class WeeklyReportController extends GetxController {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  StreamSubscription? _tugasSub;

  // ===============================
  // STATE
  // ===============================
  var weekRange = ''.obs;
  var productivity = <int>[0, 0, 0, 0, 0, 0, 0].obs; // Senin - Minggu
  var mainInsight = ''.obs;
  var insights = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    final user = _auth.currentUser;
    if (user != null) {
      _setWeekRange();
      _listenWeeklyTasks(user.uid);
    }
  }

  // ===============================
  // FIRESTORE LISTENER
  // ===============================

  void _listenWeeklyTasks(String uid) {
    final now = DateTime.now();

    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day - (now.weekday - 1),
      0, 0, 0,
    );

    final endOfWeek = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day + 6,
      23, 59, 59,
    );

    _tugasSub = _db
        .collection('users')
        .doc(uid)
        .collection('tugas')
        // sementara matikan filter ini
        // .where('isDone', isEqualTo: true)
        .where('tanggal',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfWeek))
        .where('tanggal',
            isLessThanOrEqualTo: Timestamp.fromDate(endOfWeek))
        .snapshots()
        .listen((snapshot) {
      _olahWeeklyReport(snapshot.docs);
    });

  }


  // ===============================
  // OLAH DATA
  // ===============================
  void _olahWeeklyReport(List<QueryDocumentSnapshot> docs) {
    // Reset
    productivity.value = List.filled(7, 0);
    insights.clear();

    // 🔥 JIKA BELUM ADA TUGAS SELESAI
    if (docs.isEmpty) {
      mainInsight.value =
          "Belum ada tugas yang kamu selesaikan minggu ini 🌱";

      insights.assignAll([
        "Mulai dari satu tugas kecil hari ini",
        "Checklist tugas akan muncul di laporan mingguan",
        "Konsistensi lebih penting daripada banyak",
      ]);

      productivity.assignAll(List.filled(7, 0));
      print("TOTAL DATA: ${docs.length}");
      for (var d in docs) {
        print(d.data());
      }
      return;
    }


    // 🔥 JIKA ADA DATA
    for (final d in docs) {
      final data = d.data() as Map<String, dynamic>;
      final date = (data['tanggal'] as Timestamp).toDate();
      final index = date.weekday - 1; // Senin = 0

      productivity[index]++;
      insights.add('Kamu menyelesaikan: "${data['judul']}"');
    }

    mainInsight.value =
        "Keren! Kamu telah menyelesaikan ${docs.length} tugas minggu ini 💪";
  }


  // ===============================
  // WEEK RANGE
  // ===============================
  void _setWeekRange() {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: now.weekday - 1));
    final end = start.add(const Duration(days: 6));

    final format = DateFormat('MMM d', 'id_ID');
    weekRange.value = "${format.format(start)} - ${format.format(end)}";
  }

  @override
  void onClose() {
    _tugasSub?.cancel();
    super.onClose();
  }
}
