import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/focus_timer_controller.dart';

class FocusTimerView extends GetView<FocusTimerController> {
  const FocusTimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // HEADER GRADIENT
          Container(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6EE2F5), Color(0xFF2E8B57)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: const [
                Icon(Icons.arrow_back, color: Colors.white),
                SizedBox(width: 16),
                Text(
                  "Timer Fokus",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Belajar Pra Skripsi",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // CIRCLE TIMER
          Obx(() {
            return Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 6),
              ),
              child: Center(
                child: Text(
                  controller.formatTime(controller.remainingSeconds.value),
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),

          const SizedBox(height: 30),

          // BUTTONS
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // tombol jeda
                if (controller.isRunning.value)
                  ElevatedButton.icon(
                    onPressed: controller.pauseTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    icon: const Icon(Icons.pause),
                    label: const Text("Jeda"),
                  ),

                const SizedBox(width: 12),

                // tombol mulai
                if (!controller.isRunning.value && !controller.isFinished.value)
                  ElevatedButton.icon(
                    onPressed: controller.startTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                    ),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Mulai"),
                  ),

                const SizedBox(width: 12),

                // tombol selesai
                if (controller.isFinished.value || controller.isRunning.value)
                  ElevatedButton.icon(
                    onPressed: controller.resetTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    icon: const Icon(Icons.check),
                    label: const Text("Selesai"),
                  ),
              ],
            );
          }),

          const SizedBox(height: 40),

          // PROGRESS TARGET
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Target Belajar",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Obx(() {
                return Column(
                  children: [
                    LinearProgressIndicator(
                      value: controller.completed.value / controller.target,
                      minHeight: 10,
                      backgroundColor: Colors.black12,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "${controller.completed.value}/${controller.target}",
                      style: const TextStyle(fontSize: 14),
                    )
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
