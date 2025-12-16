import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/data/auth_service.dart';
import 'package:flutter_application_1/app/modules/dashboard/views/dashboard_view.dart';
import 'package:flutter_application_1/app/modules/grupbelajar/views/grupbelajar_view.dart';
import 'package:flutter_application_1/app/modules/profile/views/profile_view.dart';
import 'package:flutter_application_1/app/modules/schedule/views/schedule_view.dart';
import 'package:flutter_application_1/app/modules/timerfokus/views/timerfokus_view.dart';
import 'package:flutter_application_1/app/modules/tugas/views/tugas_view.dart';
import 'package:flutter_application_1/app/modules/weekly_report/views/weekly_report_view.dart';


// HomeController mengatur logika utama pada halaman home
// termasuk navigasi menu, pengambilan data user,
// serta pengelolaan state tab
class HomeController extends GetxController {
   // Index tab yang sedang aktif
  var selectedIndex = 0.obs;
  // Username user yang sedang login
  var username = "".obs;
  // Foto profil user (URL)
  RxString photo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Memuat data user saat controller pertama kali dibuat
    loadUser();
     // Memuat foto profil user dari Firestore
    loadUserPhoto();
  }

// Mengambil data profil user dari AuthService
  void loadUser() async {
    final data = await AuthService.to.getUserProfile();
    if (data != null) {
      username.value = data["username"] ?? "";
    }
  }

// Mengambil foto profil user dari Firestore
  Future<void> loadUserPhoto() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists) {
      photo.value = doc['photo'] ?? '';
    }
  }

// Daftar halaman untuk navigasi tab
  final pages = [
    ScheduleView(),
    TugasView(),
    WeeklyReportView(),
    ProfileView(),
  ];

// Navigasi menu berdasarkan index
  void openMenu(int index) {
    switch (index) {
      case 0:
        Get.to(() => DashboardView());
        break;
      case 1:
        Get.to(() => TugasView());
        break;
      case 2:
        Get.to(() => TimerFokusView());
        break;
      case 3:
        Get.to(() => ScheduleView());
        break;
      case 4:
        Get.to(() => GrupbelajarView());
        break;
    }
  }

// Mengubah tab yang aktif
  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
