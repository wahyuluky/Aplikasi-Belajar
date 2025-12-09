import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditscheduleController extends GetxController {
  final subjectC = TextEditingController();
  final dateC = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> schedules = <Map<String, dynamic>>[].obs;

  String scheduleId = ""; // <-- ID jadwal yang akan di-edit

  @override
  void onInit() {
    super.onInit();

    // Ambil data dari page sebelumnya
    final data = Get.arguments;
    scheduleId = data["id"];
    subjectC.text = data["title"];
    dateC.text = data["date"];
  }

  void showPopup({
    required String title,
    required String message,
    required Color color,
    required IconData icon,
    bool autoClose = false,
  }) {
    Get.dialog(
      Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            width: 250,
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: color,
                width: 1.8,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // BULATAN ICON—SOLID WARNA
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 14),

                // JUDUL
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 6),

                // PESAN
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.3,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      barrierDismissible:
          !autoClose, // gagal → bisa tap luar, sukses → auto close
      transitionDuration: Duration.zero, // tidak slowmo
    );

    if (autoClose) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      });
    }
  }

  // ====================== UPDATE ============================
  Future<void> updateSchedule() async {
    final uid = _auth.currentUser!.uid;

    if (subjectC.text.isEmpty || dateC.text.isEmpty) {
      showPopup(
          title: 'Gagal',
          message: 'Mata Pelajaran dan Tanggal wajib diisi',
          color: const Color.fromARGB(255, 255, 107, 97),
          icon: Icons.close);
    } else {
      showPopup(
          title: 'Berhasil',
          message: 'Jadwal berhasil diperbarui',
          color: Colors.green,
          icon: Icons.check_circle);

      await _firestore
          .collection("users")
          .doc(uid)
          .collection("schedules")
          .doc(scheduleId)
          .update({
        "title": subjectC.text,
        "date": dateC.text,
      });
    }
  }
}
