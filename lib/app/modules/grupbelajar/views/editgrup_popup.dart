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
                // Foto Profile
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
                const Text(
                  "Foto Profile",
                  style: TextStyle(color: Colors.black54),
                ),

                const SizedBox(height: 25),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Edit Grup Belajar",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),

                // Input Nama Grup
                TextField(
                  controller: c.namaGrupC,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.group),
                    hintText: "Tulis disini",
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

                // Tombol Tambah
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
                    child: const Text(
                      "Edit Grup",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
