import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_teman_controller.dart';

class ProfileTemanView extends GetView<ProfileTemanController> {
  final ProfileTemanController controller = Get.put(ProfileTemanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18,),
        ),
        title: const Text(""),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6BE585), Color(0xFF6BB4FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Obx(() {
        final data = controller.profile.value;
        return Column(
          children: [
            const SizedBox(height: 20),

            // FOTO PROFIL
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(data.avatar),
            ),
            const SizedBox(height: 12),

            // BUTTON FOTO PROFIL
            TextButton(
              onPressed: () {
                // aksi pemilihan foto (diatur sendiri)
                print("Ubah foto profile");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200,
                ),
                child: const Text(
                  "Foto Profile",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(221, 132, 131, 131),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Text(
                  "Profile",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 187, 185, 185)),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // NAMA PENGGUNA
            buildInfoTile(
              icon: Icons.person,
              title: "Nama Pengguna",
              subtitle: data.name,
            ),

            const SizedBox(height: 12),

            // TELEPON
            buildInfoTile(
              icon: Icons.phone,
              title: "Telepon",
              subtitle: data.phone,
            ),
          ],
        );
      }),
    );
  }

  Widget buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 18,),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              const SizedBox(height: 3),
              Text(subtitle,
                  style: const TextStyle(
                      fontSize: 12, color: Colors.black87)),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfileTemanView(),
  ));
}