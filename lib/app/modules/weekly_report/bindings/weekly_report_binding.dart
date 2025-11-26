import 'package:get/get.dart';
import '../controllers/weekly_report_controller.dart';

class WeeklyReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeeklyReportController>(() => WeeklyReportController());
  }
}
