import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edittugas_controller.dart';

class EdittugasView extends GetView<EdittugasController> {
  final Controller  = Get.put(EdittugasController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18,),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Edit To-Do-List",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff8EF8B9), Color(0xff8CB3F4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Tugas
              const Text("Tugas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 8),
              SizedBox(
                height: 39,
                  child: TextField(
                  style: TextStyle(fontSize: 12),
                  controller: controller.tugasC,
                  decoration: InputDecoration(
                    hintText: "Tulis disini",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Keterangan
              const Text("Keterangan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 8),
              SizedBox(
                height: 39,
                child:  TextField(
                  style: TextStyle(fontSize: 12),
                  controller: controller.keteranganC,
                  // maxLines: 2,
                  decoration: InputDecoration(
                    hintText: "Tulis disini",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Tanggal Berakhir
              const Text("Tanggal Berakhir",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 8),
              SizedBox(
                height: 39,
                child: TextField(
                  style: TextStyle(fontSize: 12),
                  controller: controller.tanggalC,
                  readOnly: true,
                  onTap: () => controller.pilihTanggal(context),
                  decoration: InputDecoration(
                    hintText: "DD/MM/YYYY",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Checkbox Completed
              Obx(() => Row(
                    children: [
                      Checkbox(
                        value: controller.isDone.value,
                        onChanged: (value) {
                          controller.isDone.value = value ?? false;
                        },
                      ),
                      const Text("Completed", style: TextStyle(fontSize: 12),)
                    ],
                  )),

              const SizedBox(height: 30),

              // Tombol Aksi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Batal
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => Get.back(),
                    child: const Text("Batal", style: TextStyle(fontSize: 12, color: Colors.white),),
                  ),

                  // Tombol Simpan
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => controller.simpan(),
                    child: const Text("Simpan", style: TextStyle(fontSize: 12, color: Colors.white),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: EdittugasView(),
  ));
}
