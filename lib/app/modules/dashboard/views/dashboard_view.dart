import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/dashboard/controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeaderGradient(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildUpcomingTasksCard(),
                const SizedBox(height: 16),
                _buildStudyFocusCard(),
                const SizedBox(height: 16),
                _buildPostponedAndProductivity(),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ========================================================
  // HEADER GRADIENT
  // ========================================================
  Widget _buildHeaderGradient() {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF74E4A2), Color(0xFF93D8FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18,),
          ),
          const SizedBox(width: 12),
          // const Text(
          //   "Dashboard",
          //   style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          // ),
          const Spacer(),
          Icon(Icons.account_circle, color: Colors.white, size: 25,),
        ],
      ),
    );
  }

  // ========================================================
  // CARD – TUGAS MENDATANG
  // ========================================================
  Widget _buildUpcomingTasksCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
        ],
      ),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_month, color: Colors.green, size: 20,),
                const SizedBox(width: 8),
                const Text(
                  "Tugas Mendatang",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(width: 75),
                Text(
                  "${controller.upcomingTasks.length} Tugas Aktif",
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                )
              ],
            ),
            const SizedBox(height: 12),

            ...controller.upcomingTasks.map((task) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 12)),
                  const SizedBox(height: 3),
                  Text(
                    "${task.description} | Deadline : ${task.deadline}",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
                  ),
                ],
              ),
            )),

            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "Lihat semua",
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ),
          ],
        );
      }),
    );
  }

  // ========================================================
  // CARD – FOKUS BELAJAR
  // ========================================================
Widget _buildStudyFocusCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2)),
      ],
    ),
    child: Obx(() {
      double progress = controller.studyHoursCompleted.value /
          controller.studyHoursTarget;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE
          Row(
            children: [
              Icon(Icons.menu_book, color: Colors.green, size: 20),
              const SizedBox(width: 8),
              const Text(
                "Fokus Belajar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // MAIN CONTENT
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    SizedBox(
                    width: 120,
                    height: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.scale(
                          scale: 2,
                          child: CircularProgressIndicator(
                            value: controller.studyHoursCompleted.value /
                                controller.studyHoursTarget,
                            strokeWidth: 4,
                            color: Colors.green,
                            backgroundColor: Colors.grey.shade300,
                          ),
                        ),
                        Text(
                          (controller.studyHoursCompleted.value /
                                  controller.studyHoursTarget *
                                  100)
                              .toStringAsFixed(0),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Belajar: ${controller.studyHoursCompleted.value}/${controller.studyHoursTarget} Jam",
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                  ),
                ]
              ),
              // ▶ Lingkaran Progress

              const SizedBox(width: 40),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.studyFocusTitle.value,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.startLearning,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Mulai Belajar",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          )

        ],
      );
    }),
  );
}


  // ========================================================
  // CARD – TUGAS DITUNDA + PRODUKTIVITAS
  // ========================================================
  Widget _buildPostponedAndProductivity() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
        ],
      ),
      child: Obx(() {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= LEFT =================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.history, color: Colors.green),
                      const SizedBox(width: 8),
                      const Text(
                        "Tugas Ditunda",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${controller.postponedTasks.length} Tugas Tertunda",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                  ),
                  const SizedBox(height: 8),

                  ...controller.postponedTasks.map((task) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(task.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12)),
                            Text(task.description,
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 10)),
                          ],
                        ),
                      )),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // ================= RIGHT =================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bar_chart, color: Colors.green),
                      const SizedBox(width: 8),
                      const Text(
                        "Produktivitas",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.productivityDateRange.value,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                  ),
                  const SizedBox(height: 12),

                  _infoRow("Waktu Belajar", "${controller.studyHoursPerDay.value} Jam/Hari"),
                  _infoRow("Tugas Selesai", "${controller.tasksCompletedPercent.value}%"),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          Text(value, style: TextStyle(color: Colors.grey.shade700, fontSize: 10)),
        ],
      ),
    );
  }
}


void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: DashboardView(),
    initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => DashboardView()),
      ],
  ));
}
