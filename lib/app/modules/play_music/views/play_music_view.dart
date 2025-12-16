import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/play_music/controllers/play_music_controller.dart';

class PlayMusicView extends StatelessWidget {
  final PlayMusicController c = Get.put(PlayMusicController());

  const PlayMusicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.white,),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Play Music",
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
      body: Column(
          children: [
            const SizedBox(height: 25),
            _albumImage(),
            const SizedBox(height: 35),
            _musicDescription(),
            const SizedBox(height: 20),
            _progressBar(),
            const SizedBox(height: 50),
            _playerButtons(),
          ],
        ),
    );
  }

  // ---------------- IMAGE ALBUM ----------------
  Widget _albumImage() {
    return const CircleAvatar(
      radius: 80,
      backgroundImage: AssetImage("assets/music1.jpg"),
    );
  }

  // ---------------- TEXT TITLE & ARTIST ----------------
  Widget _musicDescription() {
    return const Column(
      children: [
        Text("Duka", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        SizedBox(height: 3),
        Text("Last Child", style: TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }

  // ---------------- SLIDER MUSIC ----------------
  Widget _progressBar() {
    return Obx(() => Column(
      children: [
        Slider(
          value: c.progress.value,
          min: 0,
          max: c.duration,
          activeColor: Colors.green,
          inactiveColor: Colors.grey[300],
          onChanged: (v) => c.changeProgress(v),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("3:05", style: TextStyle(color: Colors.black54, fontSize: 12)),
              Text("4:00", style: TextStyle(color: Colors.black54, fontSize: 12)),
            ],
          ),
        )
      ],
    ));
  }

  // ---------------- MINI PLAYER BUTTONS ----------------
  Widget _playerButtons() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.skip_previous, color: Colors.grey, size: 24),

        const SizedBox(width: 35),

        GestureDetector(
          onTap: () => c.togglePlay(),
          child: Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: Icon(
              c.isPlaying.value ? Icons.pause : Icons.play_arrow,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(width: 35),

        const Icon(Icons.skip_next, color: Colors.green, size: 24),
      ],
    ));
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: PlayMusicView(),
  ));
}
