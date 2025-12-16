import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/addtugas_controller.dart';

class AddtugasView extends StatelessWidget {
  final controller = Get.put(AddtugasController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Tugas")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller.tugasC,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: controller.ketC,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
            TextField(
              controller: controller.tanggalC,
              decoration: const InputDecoration(
                labelText: 'Tanggal',
                hintText: 'yyyy-mm-dd',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.tambahTugas,
              child: const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
