import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/focus_rest/controllers/focus_rest_controller.dart';
import 'package:flutter_application_1/app/modules/music_collection/views/music_collection_view.dart';

class FocusRestView extends StatelessWidget {
  final FocusRestController controller = Get.put(FocusRestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.white,),
          onPressed: () => Get.back(),
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            const SizedBox(height: 20),
            _progressBar(),
            const SizedBox(height: 40),
            _emoji(),
            const SizedBox(height: 30),
            _textSection(),
            const SizedBox(height: 40),
            _playButton(),
          ],
        ),
        ),
    );
  }

  // -------------------- PROGRESS BAR --------------------
  Widget _progressBar() {
    return Obx(
      () => Container(
        width: Get.width * 0.80,
        height: 30,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green, width: 3),
        ),
        child: Row(
          children: List.generate(20, (index) {
            bool filled = index < controller.progress.value;
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: filled ? Colors.lightBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // -------------------- EMOJI --------------------
  Widget _emoji() {
    return Image.asset(
      "assets/happy.png", // Ganti dengan asset emoji kamu
      width: 200,
      height: 200,
    );
  }

  // -------------------- TEXT --------------------
  Widget _textSection() {
    return Obx(
      () => Column(
        children: [
          const Text(
            "Ayo Istirahat",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Kamu sudah fokus selama ${controller.focusedMinutes.value} menit",
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  // -------------------- BUTTON --------------------
  Widget _playButton() {
    return GestureDetector(
      onTap: (){
        Get.to(MusicCollectionView());
      },
      child: Container(
        width: Get.width * 0.75,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            "Play Relaxing Music",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: FocusRestView(),
  ));
}
