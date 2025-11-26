import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/play_music/controllers/play_music_controller.dart';
import 'package:get/get.dart';

class PlayMusicView extends StatelessWidget {
  final PlayMusicController c = Get.put(PlayMusicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            SizedBox(height: 25),
            _albumImage(),
            SizedBox(height: 35),
            _musicDescription(),
            SizedBox(height: 20),
            _progressBar(),
            SizedBox(height: 50),
            _playerButtons(),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF7DE5A1), Color(0xFF8ED6FF)]),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Play Music",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 24),
        ],
      ),
    );
  }

  // ---------------- IMAGE ALBUM ----------------
  Widget _albumImage() {
    return CircleAvatar(
      radius: 90,
      backgroundImage: AssetImage("assets/music1.jpg"),
    );
  }

  // ---------------- TEXT TITLE & ARTIST ----------------
  Widget _musicDescription() {
    return Column(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
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
        Icon(Icons.skip_previous, color: Colors.grey, size: 35),

        SizedBox(width: 35),

        GestureDetector(
          onTap: () => c.togglePlay(),
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
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

        SizedBox(width: 35),

        Icon(Icons.skip_next, color: Colors.green, size: 32),
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
