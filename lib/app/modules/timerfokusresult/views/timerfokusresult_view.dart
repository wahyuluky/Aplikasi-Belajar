import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/focus_rest/views/focus_rest_view.dart';

import '../controllers/timerfokusresult_controller.dart';

class TimerfokusresultView extends GetView<TimerfokusresultController> {
  @override
  final controller = Get.put(TimerfokusresultController());

  const TimerfokusresultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.white,),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Timer Fokus",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Belajar Pra Skripsi",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 20),

            // LINGKARAN WAKTU
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 5),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "00.00",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // TOMBOL SELESAI
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text(
                  "Selesai",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                onPressed: () {
                  Get.to(FocusRestView());
                },
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Target Belajar",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),

            const SizedBox(height: 10),

            // PROGRESS BAR
            Obx(() {
              double value =
                  controller.progress.value / controller.totalTarget.value;

              return Column(
                children: [
                  LinearProgressIndicator(
                    value: value,
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${controller.progress.value}/${controller.totalTarget.value}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              );
            }),

            const SizedBox(height: 20),

            const Text(
              "Catatan Hasil Belajar",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 10),

            // CATATAN DALAM KOTAK KUNING
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                controller.hasilCatatan,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: TimerfokusresultView(),
  ));
}