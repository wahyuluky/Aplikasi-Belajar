import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/addtugas/views/addtugas_view.dart';
import 'package:flutter_application_1/app/modules/edittugas/views/edittugas_view.dart';
import 'package:flutter_application_1/app/modules/tugas/controllers/tugas_controller.dart';
import 'package:flutter_application_1/app/modules/tugas/controllers/tugas_model.dart';
import 'package:get/get.dart';

class TugasView extends StatelessWidget {
  final controller = Get.put(TugasController());

  TugasView({super.key});

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
          "To do list",
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

      // 🔥 Header Diganti Dengan Gradient Kamu
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ...List.generate(
                    controller.listTugas.length, 
                    (index) => _buildCard(controller.listTugas[index], index),
                  ),

                  const SizedBox(height: 10),
                  _inputTambah(),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------
  // 🔥 CARD TUGAS DIPERKECIL & DIPERAPIKAN
  // -------------------------------------------------------
  Widget _buildCard(TugasModel t, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6), // lebih kecil dari sebelumnya
      padding: const EdgeInsets.all(12),        // diperkecil
      decoration: BoxDecoration(
        color: Colors.green.shade50,            // lebih soft
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: t.isDone,
            onChanged: (_) => controller.toggleCheck(index),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // checkbox lebih kecil
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          ),

          const SizedBox(width: 4),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.judul,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),

                Text(
                  "${t.deskripsi} | ${t.tanggal}",
                  style: const TextStyle(fontSize: 10),
                ),

                const SizedBox(height: 6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      // onTap: () => controller.hapusTugas(index),
                      onTap: () => showDeleteDialog(index),
                      child: Row(
                        children: const [
                          Icon(Icons.delete, size: 14, color: Colors.red),
                          SizedBox(width: 3),
                          Text("Hapus",
                              style: TextStyle(color: Colors.red, fontSize: 11)),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),

                    GestureDetector(
                      onTap: () {
                        Get.to(EdittugasView());
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.edit, size: 14, color: Colors.black54),
                          SizedBox(width: 3),
                          Text("Edit", style: TextStyle(fontSize: 11)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showDeleteDialog(int index) {
    Get.defaultDialog(
      title: "Hapus Tugas?",
      middleText: "Apakah kamu yakin ingin menghapus tugas ini?",
      textCancel: "Batal",
      textConfirm: "Hapus",
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.hapusTugas(index);
        Get.back();
      },
    );
  }


  // -------------------------------------------------------
  // TOMBOL TAMBAH TUGAS
  // -------------------------------------------------------
  Widget _inputTambah() {
    return GestureDetector(
      onTap: () {
        Get.to(AddtugasView());
        
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Tambah Tugas",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

}


void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: TugasView(),
  ));
}