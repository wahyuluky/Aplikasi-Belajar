import 'package:get/get.dart';

class WeeklyReportController extends GetxController {
  // Week
  var weekRange = "Okt 1 - Okt 7".obs;

  // Productivity data (anggap jumlah materi per hari)
  var productivity = [2, 3, 4, 5, 6].obs;

  // Insight utama
  var mainInsight =
      "Keren! Kamu telah menyelesaikan 5 materi dalam minggu ini".obs;

  // List insight lainnya
  var insights = [
    "Kamu telah menyelesaikan: “Pra Skripsi”",
    "Kamu menyelesaikan latihan: “Membaca Sandi Semaphore”",
  ].obs;
}
