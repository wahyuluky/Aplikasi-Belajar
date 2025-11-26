import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/play_music/controllers/play_music_controller.dart';
import 'package:get/get.dart';

class PlayMusicView extends StatelessWidget {
  final PlayMusicController c = Get.put(PlayMusicController());

  PlayMusicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
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
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF7DE5A1), Color(0xFF8ED6FF)]),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Play Music",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  // ---------------- IMAGE ALBUM ----------------
  Widget _albumImage() {
    return const CircleAvatar(
      radius: 90,
      backgroundImage: AssetImage("assets/music1.jpg"),
    );
  }

  // ---------------- TEXT TITLE & ARTIST ----------------
  Widget _musicDescription() {
    return const Column(
      children: [
        Text("Duka", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        SizedBox(height: 3),
        Text("Last Child", style: TextStyle(fontSize: 14, color: Colors.black54)),
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
        const Icon(Icons.skip_previous, color: Colors.grey, size: 35),

        const SizedBox(width: 35),

        GestureDetector(
          onTap: () => c.togglePlay(),
          child: Container(
            width: 55,
            height: 55,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: Icon(
              c.isPlaying.value ? Icons.pause : Icons.play_arrow,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(width: 35),

        const Icon(Icons.skip_next, color: Colors.green, size: 32),
      ],
    ));
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: PlayMusicView(),
    initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => PlayMusicView()),
      ],
  ));
}
