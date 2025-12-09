import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  var selectedDate = DateTime.now().obs;
  var currentMonth = DateTime.now().obs;

  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  RxList<Map<String, dynamic>> schedules = <Map<String, dynamic>>[].obs;

  Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs; // <- default month

  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSchedules();
  }

  void fetchSchedules() {
    String uid = _auth.currentUser!.uid;

    _firestore.collection("users")
       .doc(uid)
       .collection("schedules")
       .snapshots()
       .listen((snapshot) {
        schedules.value = snapshot.docs.map((doc) {
          return {
            "id": doc.id,
            "title": doc["title"],
            "date": doc["date"],
          };
        }).toList();
    });
  }

  Future<void> deleteSchedule(String id) async {
    String uid = _auth.currentUser!.uid;

    await _firestore.collection("users")
      .doc(uid)
      .collection("schedules")
      .doc(id)
      .delete();
  }

  // ====================== LOAD DATA ============================
  Future<void> loadSchedules() async {
    final uid = _auth.currentUser!.uid;

    final result = await _firestore
        .collection("users")
        .doc(uid)
        .collection("schedules")
        .orderBy("createdAt")
        .get();

    schedules.value = result.docs.map((doc) {
      return {
        "id": doc.id,
        "title": doc["title"],
        "date": doc["date"],
      };
    }).toList();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

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


  // ====================== ADD ============================
  Future<void> addSchedule(String title, String date) async {
    final uid = _auth.currentUser!.uid;

    await _firestore
        .collection("users")
        .doc(uid)
        .collection("schedules")
        .add({
      "title": title,
      "date": date,
      "createdAt": DateTime.now(),
    });

    loadSchedules(); // refresh list
  }

  // ====================== UPDATE ============================
  Future<void> updateSchedule(String id, String title, String date) async {
    final uid = _auth.currentUser!.uid;

    await _firestore
        .collection("users")
        .doc(uid)
        .collection("schedules")
        .doc(id)
        .update({
      "title": title,
      "date": date,
    });

    loadSchedules();
  }

}
