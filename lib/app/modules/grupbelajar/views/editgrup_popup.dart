import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/editgrup_controller.dart';
import '../controllers/grupbelajar_controller.dart';

class EditgrupPopup {
  static void show(int index) {
    final grupC = Get.find<GrupbelajarController>();
    final c = Get.put(EditgrupController());

    // ❗ Prefill data lama
    c.namaGrupC.text = grupC.grupList[index]["nama"]!;
    c.fotoUrl.value = grupC.grupList[index]["foto"]!;

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
                      backgroundImage: NetworkImage(c.fotoUrl.value),
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
                    onPressed: () {
                      if (c.namaGrupC.text.isEmpty) {
                        Get.snackbar("Error", "Nama grup harus diisi");
                        return;
                      }

                      grupC.editGrup(
                        index,
                        c.namaGrupC.text,
                        c.fotoUrl.value,
                      );

                      Get.back();
                      Get.delete<EditgrupController>();

                      suksesEditGrup();
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
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
