import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var currentMonth = DateTime.now().obs;

  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs; // <- default month

  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  var schedules = <Map<String, dynamic>>[
    {
      "title": "Pra Skripsi",
      "date": "20-12-2025",
    }
  ].obs;

  void nextMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month + 1,
    );
  }

  void previousMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month - 1,
    );
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void deleteSchedule(int index) {
    schedules.removeAt(index);
  }

  void addSchedule(String title, String date) {
    schedules.add({"title": title, "date": date});
  }
}
