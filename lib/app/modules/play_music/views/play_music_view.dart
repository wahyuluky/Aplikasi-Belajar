import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/modules/play_music/controllers/play_music_controller.dart';

class PlayMusicView extends StatelessWidget {
  final PlayMusicController c = Get.find<PlayMusicController>();

  PlayMusicView({super.key});

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
      body: SingleChildScrollView(
        child: Column(
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
        ),
    );
  }

  // ---------------- IMAGE ALBUM ----------------
  Widget _albumImage() {
    return const CircleAvatar(
      radius: 80,
      backgroundColor: Colors.green,
      child: const Icon(Icons.music_note, color: Colors.green),
    );
  }

  // ---------------- TEXT TITLE & ARTIST ----------------
  Widget _musicDescription() {
    return Obx(() {
      final song = c.song;
      return Column(
        children: [
          Text(
            song["title"] ?? "-",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 3),
          Text(
            song["artist"] ?? "-",
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      );
    });
  }



  // ---------------- SLIDER MUSIC ----------------
  Widget _progressBar() {
    return StreamBuilder<Duration>(
      stream: c.musicC.player.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final duration =
            c.musicC.player.duration ?? Duration.zero;

        return Column(
          children: [
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds
                  .clamp(0, duration.inSeconds)
                  .toDouble(),
              onChanged: (v) {
                c.musicC.player.seek(
                  Duration(seconds: v.toInt()),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_format(position)),
                  Text(_format(duration)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

String _format(Duration d) =>
    "${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";


  // ---------------- MINI PLAYER BUTTONS ----------------
  Widget _playerButtons() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous, size: 24, color: Colors.green,),
          onPressed: c.previous,
        ),
        SizedBox(width: 35),

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

         IconButton(
        icon: const Icon(Icons.skip_next, size: 24, color: Colors.green),
        onPressed: c.next,
      ),
      ],
    ));
  }
}

