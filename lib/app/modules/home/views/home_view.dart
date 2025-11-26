import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final controller = Get.put(HomeController());

  final List<Map<String, dynamic>> menuItems = [
    {"icon": Icons.bar_chart, "label": "Dashboard"},
    {"icon": Icons.assignment_outlined, "label": "Tugas"},
    {"icon": Icons.menu_book_outlined, "label": "Belajar"},
    {"icon": Icons.calendar_month_outlined, "label": "Jadwal"},
    {"icon": Icons.people_alt_outlined, "label": "Diskusi"},
  ];

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: BottomNavigationBar(
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
          
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // ------------------ HEADER ------------------
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/User.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ).paddingOnly(top: 15),

                      const SizedBox(height: 10),
                      const Text(
                        "Hello, Nabila",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Search Bar
                      Container(
                        height: 35,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const TextField(
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Colors.grey, size: 18,),
                            hintText: "Tulis disini",
                            contentPadding: EdgeInsets.all(12),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                // ------------------ MENU GRID ------------------

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,           // 3 kolom
                      crossAxisSpacing: 30.0,        // jarak antar kolom
                      mainAxisSpacing: 30.0,         // jarak antar baris
                      // childAspectRatio: 1,  
                      // shrinkWrap: true,       // bentuk kotak proporsional
                    ),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return Container(
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
                      );
                    },
                  ),
                )


              ],// akhir
            ),
          ),
        ));
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeView(),
    initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeView()),
      ],
  ));
}
