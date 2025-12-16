import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/timerfokus/controllers/timerfokus_controller.dart';
import 'package:flutter_application_1/app/modules/timerfokusresult/views/timerfokusresult_view.dart';

class TimerFokusView extends GetView<TimerFokusController> {
  final controller = Get.put(TimerFokusController());

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
              colors: [Color(0xFF74E4A2), Color(0xFF93D8FF)],
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

            // TIMER BULAT
            Center(
              child: Obx(() {
                return Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green,
                      width: 5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    controller.waktu.value.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 25),

            // TOMBOL - MULAI / JEDA / SELESAI
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TOMBOL MULAI / PAUSE
                Obx(() {
                  return ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(
                      controller.isRunning.value
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    label: Text(
                      controller.isRunning.value ? "Jeda" : "Mulai",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    onPressed: () {
                      if (controller.isRunning.value) {
                        controller.jeda();
                      } else {
                        controller.mulaiTimer();
                      }
                    },
                  );
                }),

                const SizedBox(width: 10),

                // TOMBOL RESET
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.restore, color: Colors.white),
                  label: const Text("Reset",
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  onPressed: () => controller.selesai(),
                ),
              ],
            ),
            const SizedBox(height: 10),

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
                  label: const Text("Selesai",
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  onPressed: () {
                    Get.to(TimerfokusresultView());
                  },
                ),
      ),
            const SizedBox(height: 40),

            // TARGET BELAJAR
            const Text(
              "Target Belajar",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 10),

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
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: TimerFokusView(),
  ));
}
