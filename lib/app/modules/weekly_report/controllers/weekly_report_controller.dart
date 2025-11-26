import 'package:get/get.dart';

class WeeklyReportController extends GetxController {
  // Contoh data untuk grafik
  final barHeights = <double>[40, 55, 70, 85, 100, 120].obs;

  // Contoh week info
  final weekRange = "Okt 1 - Okt 7".obs;

  // Insight (bisa dinamis)
  final insightText =
      "Keren! Kamu telah menyelesaikan 5 materi dalam minggu ini".obs;

  // Checklist items
  final checklist = [
    "Kamu telah menyelesaikan: \"Pra Skripsi\"",
    "Kamu menyelesaikan latihan: \"Membaca Sandi Semaphore\""
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Tambahkan logic jika perlu, misal ambil data dari API
  }
}
