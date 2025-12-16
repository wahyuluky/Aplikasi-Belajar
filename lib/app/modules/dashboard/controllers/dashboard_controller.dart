import 'package:get/get.dart';
import '../../tugas/controllers/tugas_controller.dart';

/// MODEL LAMA (DIPERTAHANKAN UNTUK VIEW)
class Task {
  final String title;
  final String description;
  final String deadline;

  Task({
    required this.title,
    required this.description,
    required this.deadline,
  });
}

class PostponedTask {
  final String title;
  final String description;

  PostponedTask({
    required this.title,
    required this.description,
  });
}

class DashboardController extends GetxController {
  final TugasController tugasC = Get.find<TugasController>();

  /// ===============================
  /// SESUAI YANG DIPAKAI VIEW
  /// ===============================
  var upcomingTasks = <Task>[].obs;
  var postponedTasks = <PostponedTask>[].obs;

  var totalMendatang = 0.obs;
  var totalDitunda = 0.obs;

  /// ===============================
  /// DATA LAIN (TIDAK DIUBAH)
  /// ===============================
  var studyFocusTitle = 'Belajar Pra Skripsi'.obs;
  var studyHoursCompleted = 0.obs;
  final int studyHoursTarget = 4;

  var productivityDateRange = '19 - 25 Okt 2025'.obs;
  var studyHoursPerDay = 3.5.obs;
  var tasksCompletedPercent = 50.obs;

  @override
  void onInit() {
    super.onInit();

    /// 🔥 LISTEN REALTIME DARI FIRESTORE
    ever(tugasC.listTugas, (_) => _olahData());
  }

  void _olahData() {
    final aktif = tugasC.listTugas.where((t) => !t.isDone).toList();

    totalMendatang.value = aktif.length;
    totalDitunda.value = aktif.length;

    /// ===============================
    /// TUGAS MENDATANG (3 TERDEKAT)
    /// ===============================
    final mendatang = [...aktif]
      ..sort((a, b) => a.tanggal.compareTo(b.tanggal));

    upcomingTasks.value = mendatang
        .take(3)
        .map((t) => Task(
              title: t.judul,
              description: t.deskripsi,
              deadline: _formatTanggal(t.tanggal),
            ))
        .toList();

    /// ===============================
    /// TUGAS DITUNDA (3 TERLAMA)
    /// ===============================
    final ditunda = [...aktif]
      ..sort((a, b) => b.tanggal.compareTo(a.tanggal));

    postponedTasks.value = ditunda
        .take(3)
        .map((t) => PostponedTask(
              title: t.judul,
              description: "Ditunda hingga ${_formatTanggal(t.tanggal)}",
            ))
        .toList();
  }

  String _formatTanggal(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }



  void startLearning() {
    if (studyHoursCompleted.value < studyHoursTarget) {
      studyHoursCompleted.value++;
    }
  }
}
