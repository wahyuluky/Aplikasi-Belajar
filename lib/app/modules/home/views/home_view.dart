import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_application_1/app/modules/profile/views/profile_view.dart';
import 'package:flutter_application_1/app/modules/schedule/views/schedule_view.dart';
import 'package:flutter_application_1/app/modules/tugas/views/tugas_view.dart';
import 'package:flutter_application_1/app/modules/weekly_report/views/weekly_report_view.dart';

class HomeView extends StatelessWidget {
  final controller = Get.put(HomeController());

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

  // ================== BODY SWITCH ====================
  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return _homeMenu(); // home + grid
      case 1:
        return _jadwalPage();
      case 2:
        return _tugasPage();
      case 3:
        return _reportPage();
      case 4:
        return _profilPage();
      default:
        return _homeMenu();
    }
  }

  // ================== HALAMAN HOME ====================
  Widget _homeMenu() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- HEADER ----------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
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
                ).paddingOnly(top: 15),

                const SizedBox(height: 10),
                Obx(() => Text(
                      "Hello, ${controller.username.value}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),

          const SizedBox(height: 5),

          // ---------------- GRID MENU ----------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 30.0,
                mainAxisSpacing: 30.0,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => controller.openMenu(index),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          menuItems[index]["icon"],
                          color: Colors.green,
                          size: 20,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          menuItems[index]["label"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )

          )
        ],
      ),
    );
  }

  // ================= HALAMAN LAIN =====================
  Widget _jadwalPage() {
    return ScheduleView();
  }

  Widget _tugasPage() {
    return TugasView();
  }

  Widget _reportPage() {
    return WeeklyReportView();
  }

  Widget _profilPage() {
    return ProfileView();
  }
}

