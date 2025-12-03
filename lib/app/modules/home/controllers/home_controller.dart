import 'package:flutter_application_1/app/modules/dashboard/views/dashboard_view.dart';
import 'package:flutter_application_1/app/modules/grupbelajar/views/grupbelajar_view.dart';
import 'package:flutter_application_1/app/modules/profile/views/profile_view.dart';
import 'package:flutter_application_1/app/modules/schedule/views/schedule_view.dart';
import 'package:flutter_application_1/app/modules/timerfokus/views/timerfokus_view.dart';
import 'package:flutter_application_1/app/modules/tugas/views/tugas_view.dart';
import 'package:flutter_application_1/app/modules/weekly_report/views/weekly_report_view.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  final pages = [
    ScheduleView(),
    TugasView(),
    WeeklyReportView(),
    ProfileView(),
  ];

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

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
