import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class EditProfileView extends StatelessWidget {
  final controller = Get.find<ProfileController>();

  EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            Column(
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
                // const Text(
                //   "Edit Foto",
                //   style: TextStyle(
                //       fontSize: 13,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.grey),
                // ),
                GestureDetector(
                    onTap: () => Get.to(() => EditProfileView()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade100,
                      ),
                      child: const Text(
                        "Edit Foto",
                        style: TextStyle(color: Color.fromARGB(221, 88, 87, 87)),
                      ),
                    ),
                  )
              ],
            ),

            const SizedBox(height: 20),

            // ---------------- FORM ----------------
            _editField(
                icon: Icons.email_outlined,
                title: "Email",
                controller: controller.emailC),
            _editField(
                icon: Icons.phone,
                title: "Telepon",
                controller: controller.phoneC),
            _editField(
                icon: Icons.location_on_outlined,
                title: "Alamat",
                controller: controller.addressC),
            _editField(
                icon: Icons.calendar_today,
                title: "Lahir",
                controller: controller.birthDateC),

            const SizedBox(height: 20),

            // ---------------- SIMPAN BUTTON ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: controller.updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: const Size(double.infinity, 39),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Simpan",
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

  // WIDGET FIELD EDIT
  Widget _editField(
      {required IconData icon,
      required String title,
      required TextEditingController controller}) {
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
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 10),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          )
        ],
      ),
    );
  }
}
