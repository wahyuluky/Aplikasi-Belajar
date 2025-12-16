import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/grupbelajar/controllers/editgrup_controller.dart';

class EditgrupPopup {
  static void show({
    required String id, 
    required String nama, 
    required String foto}) 
    {
    final c = Get.put(EditgrupController());
    // isi nilai awal
    c.namaGrupC.text = nama;
    c.foto.value = foto;
    c.groupId = id;


    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                  return GestureDetector(
                    onTap: c.pilihFoto,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(c.foto.value),
                    ),
                  );
                }),

                const SizedBox(height: 10),
                const Text("Foto Profile",
                    style: TextStyle(color: Colors.black54)),

                const SizedBox(height: 25),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Edit Grup Belajar",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: c.namaGrupC,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.group),
                    labelText: "Nama Grup",
                    fillColor: const Color(0xffF5F5F5),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                   onPressed: () async {
                      if (c.namaGrupC.text.isEmpty) {
                        Get.snackbar("Error", "Nama grup harus diisi");
                        return;
                      }

                      await c.updateGrup(
                        c.groupId, 
                        c.namaGrupC.text, 
                        c.foto.value);

                      Get.back(); // Tutup popup
                      Get.delete<EditgrupController>();
                    },
                    child: const Text("Edit Grup",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // NOTIFIKASI SUKSES EDIT
  static void suksesEditGrup() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(color: Color(0xFF4ADE80), width: 2),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          width: 280,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF4ADE80),
                child: Icon(Icons.check, color: Colors.white, size: 45),
              ),
              SizedBox(height: 20),
              Text(
                "Grup berhasil diedit!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (Get.isDialogOpen ?? false) Get.back();
    });
  }
}
