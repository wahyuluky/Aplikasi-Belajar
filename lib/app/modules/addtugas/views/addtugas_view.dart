import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/tugas/views/tugas_view.dart';
import 'package:get/get.dart';
import '../../tugas/controllers/tugas_controller.dart';
import '../../tugas/controllers/tugas_model.dart';

class AddtugasView extends StatelessWidget {
  AddtugasView({super.key});

  // controller utama untuk list tugas
  final tugasController = Get.find<TugasController>();

  // text controller input
  final tugasC = TextEditingController();
  final keteranganC = TextEditingController();
  final tanggalC = TextEditingController();

  final isCompleted = false.obs;

Future<void> pilihTanggal(BuildContext context) async {
  DateTime? pilih = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2030),
  );

  if (pilih != null) {
    tanggalC.text = "${pilih.day}/${pilih.month}/${pilih.year}";
  }
}


  void simpan() {
    if (tugasC.text.isEmpty || keteranganC.text.isEmpty || tanggalC.text.isEmpty) {
      Get.snackbar(
        "Gagal",
        "Semua field harus diisi!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    tugasController.tambahTugas(
      TugasModel(
        judul: tugasC.text,
        deskripsi: keteranganC.text,
        tanggal: tanggalC.text,
        isDone: isCompleted.value,
      ),
    );

    Get.off(() => TugasView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Tambah To-Do-List",
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
              const Text("Tugas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 8),
              SizedBox(
                height: 39,
                child: TextField(
                  controller: tugasC,
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    hintText: "Tulis disini",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Text("Keterangan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 8),
              SizedBox(
                height: 39,
                child: TextField(
                  controller: keteranganC,
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    hintText: "Tulis disini",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Text("Tanggal Berakhir", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 8),
              SizedBox(
                height: 39,
                child: TextField(
                  controller: tanggalC,
                  style: const TextStyle(fontSize: 12),
                  readOnly: true,
                  onTap: () => pilihTanggal(context),
                  decoration: InputDecoration(
                    hintText: "DD/MM/YYYY",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      value: isCompleted.value,
                      onChanged: (val) => isCompleted.value = val ?? false,
                    ),
                    const Text("Completed", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => Get.back(),
                    child: const Text("Batal", style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: simpan,
                    child: const Text("Simpan", style: TextStyle(fontSize: 12, color: Colors.white)),
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