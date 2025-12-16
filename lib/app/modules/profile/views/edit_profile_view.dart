import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/profile_controller.dart';

class EditProfileView extends StatelessWidget {
  final controller = Get.find<ProfileController>();

  EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18,),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ---------------- PROFILE PICTURE ----------------
            Column(
              children: [
                Obx(() {
                    return CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: controller.photo.value.isEmpty
                          ? Image.asset("assets/akun.png", height: 120, width: 120, fit: BoxFit.cover,)
                          : Image.file(File(controller.photo.value), height: 120, width: 120, fit: BoxFit.cover),
                      ),
                    );
                  }),
                const SizedBox(height: 12),
                GestureDetector(
                    onTap: () => _showPhotoOptions(context),
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

  void _showPhotoOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Pilih Foto",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Pilih dari Galeri"),
              onTap: () async {
                Navigator.pop(context);
                final ImagePicker picker = ImagePicker();
                final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
                if (photo != null) {
                  controller.updatePhoto(photo.path);
                }
              },
            ),

            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Ambil Foto"),
              onTap: () async {
                Navigator.pop(context);
                final ImagePicker picker = ImagePicker();
                final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                if (photo != null) {
                  controller.updatePhoto(photo.path);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

}
