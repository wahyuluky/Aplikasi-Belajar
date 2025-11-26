import 'package:get/get.dart';

class Task {
  final String title;
  final String description;
  final String deadline;

  Task({required this.title, required this.description, required this.deadline});
}

class PostponedTask {
  final String title;
  final String description;

  PostponedTask({required this.title, required this.description});
}

class DashboardController extends GetxController {
  // Tugas Mendatang
  var upcomingTasks = <Task>[
    Task(
      title: 'Etika dan Profesi',
      description: 'Kode Etik',
      deadline: '20 Oktober 2025',
    ),
    Task(
      title: 'Pra Skripsi',
      description: 'Identifikasi Topik',
      deadline: '25 Oktober 2025',
    ),
    Task(
      title: 'Rekayasa Interaksi',
      description: 'Prototype',
      deadline: '26 Oktober 2025',
    ),
  ].obs;

  // Fokus Belajar
  var studyFocusTitle = 'Belajar Pra Skripsi'.obs;
  var studyHoursCompleted = 0.obs;
  final int studyHoursTarget = 4;

  // Tugas Ditunda
  var postponedTasks = <PostponedTask>[
    PostponedTask(
      title: 'Presentasi Pra Skripsi',
      description: 'Ditunda hingga 24 Oktober',
    ),
    PostponedTask(
      title: 'Kuis Etika Profesi',
      description: 'Ditunda hingga 19 Oktober',
    ),
  ].obs;

  // Produktivitas
  var productivityDateRange = '19 - 25 Okt 2025'.obs;
  var studyHoursPerDay = 3.5.obs;
  var tasksCompletedPercent = 50.obs;

  void startLearning() {
    if (studyHoursCompleted.value < studyHoursTarget) {
      studyHoursCompleted.value++;
    }
  }
}