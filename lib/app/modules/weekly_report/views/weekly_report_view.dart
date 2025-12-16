import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/weekly_report_controller.dart';

class WeeklyReportView extends StatelessWidget {
  final WeeklyReportController controller =
      Get.put(WeeklyReportController());

  WeeklyReportView({super.key});

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
          "Report",
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWeekInfo(),
                  const SizedBox(height: 10),
                  _buildProductivityChart(),
                  const SizedBox(height: 30),
                  _buildInsights(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  // =========================================
  // WEEK INFO
  // =========================================
  Widget _buildWeekInfo() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Week : ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  controller.weekRange.value,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Productivity",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ],
        ));
  }

  // =========================================
  // PRODUCTIVITY CHART
  // =========================================
  Widget _buildProductivityChart() {
    return Obx(() {
      final data = controller.productivity;

      return Container(
        margin: const EdgeInsets.only(top: 16),
        height: 180,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            data.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 35,
              height: data[i] * 18.0,
              decoration: BoxDecoration(
                color: const Color(0xFF86F7A7),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      );
    });
  }

  // =========================================
  // INSIGHTS
  // =========================================
  Widget _buildInsights() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Insights",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Main insight card
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE7B5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  controller.mainInsight.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Additional insights list
            Column(
              children: controller.insights
                  .map(
                    (text) => _buildInsightItem(text),
                  )
                  .toList(),
            ),
          ],
        ));
  }

  Widget _buildInsightItem(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline,
              color: Colors.green, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}


void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: WeeklyReportView(),
  ));
}