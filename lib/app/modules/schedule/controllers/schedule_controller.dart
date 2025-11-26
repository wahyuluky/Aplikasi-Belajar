import 'package:flutter_application_1/app/modules/schedule/models/schedule_models.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController {
  // Observables untuk data:
  // selectedDate diinisialisasi ke hari ini (saat ini)
  var selectedDate = DateTime.now().obs;
  // schedules diinisialisasi sebagai list kosong, siap diisi user
  var schedules = <Schedule>[].obs;
  
  // Method onInit tidak lagi diperlukan karena tidak ada inisialisasi data awal

  // --- LOGIKA UTAMA ---

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
    // Logika mengambil jadwal dari API/database berdasarkan tanggal (jika terhubung)
  }

  // 1. TAMBAH JADWAL
  void addJadwal(String mataKuliah, DateTime tanggal) {
    // Generate ID unik
    final newJadwal = Schedule(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // ID unik dari timestamp
      mataKuliah: mataKuliah,
      tanggal: tanggal,
    );
    schedules.add(newJadwal);
    setSelectedDate(tanggal); // Langsung pindah ke tanggal jadwal yang baru dibuat
    Get.back(); // Kembali ke halaman utama setelah tambah
    Get.snackbar('Berhasil', 'Jadwal "${mataKuliah}" berhasil ditambahkan!', snackPosition: SnackPosition.BOTTOM);
  }

  // 2. EDIT JADWAL
  void editJadwal(String id, String newMataKuliah, DateTime newTanggal) {
    final index = schedules.indexWhere((j) => j.id == id);
    if (index != -1) {
      schedules[index] = Schedule(
        id: id,
        mataKuliah: newMataKuliah,
        tanggal: newTanggal,
      );
      schedules.refresh(); // Memaksa update UI
      setSelectedDate(newTanggal); // Langsung pindah ke tanggal yang diubah
      Get.back(); // Kembali ke halaman utama setelah edit
      Get.snackbar('Berhasil', 'Jadwal "${newMataKuliah}" berhasil diubah!', snackPosition: SnackPosition.BOTTOM);
    }
  }

  // 3. HAPUS JADWAL
  void deleteJadwal(String id) {
    schedules.removeWhere((j) => j.id == id);
    Get.snackbar('Terhapus', 'Jadwal berhasil dihapus.', snackPosition: SnackPosition.BOTTOM);
  }

  // Filter jadwal berdasarkan tanggal yang dipilih di kalender
  List<Schedule> get filteredSchedules {
    return schedules.where((j) {
      // Bandingkan hanya hari, bulan, dan tahun
      return j.tanggal.year == selectedDate.value.year &&
             j.tanggal.month == selectedDate.value.month &&
             j.tanggal.day == selectedDate.value.day;
    }).toList();
  }

  // Cek apakah ada jadwal di tanggal tertentu (untuk menandai tanggal di kalender)
  bool hasScheduleOnDate(DateTime date) {
    return schedules.any((j) {
      return j.tanggal.year == date.year &&
             j.tanggal.month == date.month &&
             j.tanggal.day == date.day;
    });
  }
}