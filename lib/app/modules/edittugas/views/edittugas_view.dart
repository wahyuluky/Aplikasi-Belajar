import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edittugas_controller.dart';

class EdittugasView extends StatelessWidget {
  final controller = Get.put(EdittugasController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Tugas")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller.judulC,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: controller.ketC,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
            TextField(
              controller: controller.tanggalC,
              decoration: const InputDecoration(labelText: 'Tanggal'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.updateTugas,
              child: const Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
