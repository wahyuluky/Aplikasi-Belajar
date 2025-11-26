import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_application_1/app/modules/profile/views/edit_profile_view.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          children: [
            // ---------------- HEADER ----------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF74E4A2), Color(0xFF93D8FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8), // kanan & bawah
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 18),
                    ),
                  ),
                  const SizedBox(width: 50),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // ---------------- PROFILE PICTURE ----------------
            Container(
              // transform: Matrix4.translationValues(0, -60, 0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: Image.asset(
                        "assets/User.png",
                        fit: BoxFit.cover,
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Get.to(() => EditProfileView()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade100,
                      ),
                      child: const Text(
                        "Edit Profil",
                        style: TextStyle(color: Color.fromARGB(221, 88, 87, 87)),
                      ),
                    ),
                  )

                ],
              ),
            ),

            // ---------------- PROFILE INFO ----------------
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Profile",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),

            const SizedBox(height: 10),

            // FIELD EMAIL
            _profileItem(
              icon: Icons.email_outlined,
              title: "Email",
              value: controller.email.value,
            ),

            // FIELD TELEPON
            _profileItem(
              icon: Icons.phone,
              title: "Telepon",
              value: controller.phone.value,
            ),

            // FIELD ALAMAT
            _profileItem(
              icon: Icons.location_on_outlined,
              title: "Alamat",
              value: controller.address.value,
            ),

            // FIELD LAHIR
            _profileItem(
              icon: Icons.calendar_today,
              title: "Lahir",
              value: controller.birthDate.value,
            ),

            const SizedBox(height: 20),

            // ---------------- LOGOUT BUTTON ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: controller.logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: const Size(double.infinity, 39),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ------------------ WIDGET ITEM PROFILE ------------------
  Widget _profileItem({required IconData icon, required String title, required String value}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, right: 16, left: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 15),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 10, color: Colors.black54)),
                const SizedBox(height: 3),
                Text(value,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfileView(),
    initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => ProfileView()),
      ],
  ));
}