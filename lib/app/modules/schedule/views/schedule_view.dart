import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/addschedule/views/addschedule_view.dart';
import 'package:flutter_application_1/app/modules/editschedule/views/editschedule_view.dart';
import 'package:flutter_application_1/app/modules/schedule/controllers/schedule_controller.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';


class ScheduleView extends StatelessWidget {
  final ScheduleController c = Get.put(ScheduleController());

  ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.white,),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Jadwal",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF74E4A2), Color(0xFF93D8FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
          children: [
            _calendar(),  // diganti dengan TableCalendar
            _sectionTitle(),
            _scheduleList(),
          ],
        ),
      );
  }

  // --------------------- TABLE CALENDAR ---------------------
  Widget _calendar() {
  return Obx(() {
    return Column(
      children: [
        // 🗓 TableCalendar
        TableCalendar(
          locale: 'id_ID',
          focusedDay: c.focusedDay.value,
          firstDay: DateTime(2000),
          lastDay: DateTime(2100),
          currentDay: c.selectedDay.value,
          calendarFormat: c.calendarFormat.value,

          // 🔁 Update format ketika di-swipe
          onFormatChanged: (format) {
            c.calendarFormat.value = format;
          },

          // 📌 When a day selected
          selectedDayPredicate: (day) =>
              isSameDay(c.selectedDay.value, day),
          onDaySelected: (selected, focused) {
            c.selectedDay.value = selected;
            c.focusedDay.value = focused;
          },
          // 🔽 Styling ukuran font calendar
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(fontSize: 11),
            weekendStyle: TextStyle(fontSize: 11),
          ),
          headerStyle: const HeaderStyle(
            titleTextStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            formatButtonTextStyle: TextStyle(fontSize: 11),
          ),
          calendarStyle: const CalendarStyle(
            defaultTextStyle: TextStyle(fontSize: 11),
            weekendTextStyle: TextStyle(fontSize: 11),
            selectedTextStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            todayTextStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  });
}

  // ----------------------------------------------------------


  Widget _sectionTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Jadwal",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),

          // === BUTTON ADD ===
          GestureDetector(
            onTap: () {
              Get.to(AddscheduleView());   // halaman tujuan
            },
            child: const Icon(
              Icons.add,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }


  Widget _scheduleList() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: c.schedules.length,
          itemBuilder: (context, index) {
            var item = c.schedules[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE6FCE6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['title'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(item['date'], style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                      ],
                    ),
                  ),

                  // Hapus
                  Padding(
                    padding: const EdgeInsets.only(top: 6),  // 🔽 turunkan sedikit
                    child: GestureDetector(
                      onTap: () => showDeleteDialog(index),
                      child: Row(
                        children: const [
                          Icon(Icons.delete, color: Colors.red, size: 18),
                          SizedBox(width: 4),
                          Text("Hapus", style: TextStyle(color: Colors.red, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Edit
                  Padding(
                    padding: const EdgeInsets.only(top: 6),  // 🔽 turunkan sedikit
                    child: GestureDetector(
                      onTap: () {
                        Get.to(EditscheduleView());
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.edit, color: Colors.green, size: 18),
                          SizedBox(width: 4),
                          Text("Edit", style: TextStyle(color: Colors.green, fontSize: 12)),
                        ],
                      ),
            ),
                  ),
                ],
              ),


            );
          },
        );
      }),
    );
  }

    void showDeleteDialog(int index) {
    Get.defaultDialog(
      title: "Hapus Tugas?",
      middleText: "Apakah kamu yakin ingin menghapus tugas ini?",
      textCancel: "Batal",
      textConfirm: "Hapus",
      confirmTextColor: Colors.white,
      onConfirm: () {
        c.deleteSchedule(index);
        Get.back();
      },
    );
  }
}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null); 
  
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: ScheduleView(),
  ));
}