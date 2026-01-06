import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_application_1/app/modules/profile/views/profile_view.dart';
import 'package:flutter_application_1/app/modules/schedule/views/schedule_view.dart';
import 'package:flutter_application_1/app/modules/tugas/views/tugas_view.dart';
import 'package:flutter_application_1/app/modules/weekly_report/views/weekly_report_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  final List<Map<String, dynamic>> menuItems = [
    {"icon": Icons.bar_chart, "label": "Dashboard"},
    {"icon": Icons.assignment_outlined, "label": "Tugas"},
    {"icon": Icons.menu_book_outlined, "label": "Belajar"},
    {"icon": Icons.calendar_month_outlined, "label": "Jadwal"},
    {"icon": Icons.people_alt_outlined, "label": "Diskusi"},
  ];


  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTab,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: "Jadwal",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task),
                label: "Tugas",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assessment),
                label: "Report",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profil",
              ),
            ],
          ),

          // ====== BODY SESUAI TAB ======
          body: _buildBody(controller.selectedIndex.value),
        ));
  }

  // ================= BODY SWITCH =================
  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return _homeMenu();
      case 1:
        return ScheduleView();
      case 2:
        return TugasView();
      case 3:
        return WeeklyReportView();
      case 4:
        return ProfileView();
      default:
        return _homeMenu();
    }
  }

  // ================= HOME PAGE ==================
  Widget _homeMenu() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------- HEADER --------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF74E4A2), Color(0xFF93D8FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    GestureDetector(
                      onTap: () => controller.changeTab(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Obx(() {
                          final path = controller.photo.value;
                          final file = File(path);

                          return CircleAvatar(
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: path.isEmpty || !file.existsSync()
                              ? Image.asset(
                                "assets/akun.png", 
                                height: 120, 
                                width: 120, 
                                fit: BoxFit.cover,
                              )
                              : Image.file(
                                file, 
                                height: 120, 
                                width: 120, 
                                fit: BoxFit.cover
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // -------- GRID MENU --------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => controller.openMenu(index),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          menuItems[index]["icon"],
                          color: Colors.green,
                          size: 22,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          menuItems[index]["label"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

