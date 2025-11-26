import 'package:flutter/material.dart';
import 'chat/chat_room_page.dart'; // SESUAIKAN dengan folder mu

class GroupModel {
  final String title;
  final String imageUrl;
  GroupModel({required this.title, required this.imageUrl});
}

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<GroupModel> groups = [
      GroupModel(title: "Rekayasa Interaksi", imageUrl: "https://i.imgur.com/BoN9kdC.png"),
      GroupModel(title: "Rekayasa Ulang Sistem", imageUrl: "https://i.imgur.com/BoN9kdC.png"),
      GroupModel(title: "Rekayasa Kebutuhan", imageUrl: "https://i.imgur.com/BoN9kdC.png"),
      GroupModel(title: "Pra Skripsi", imageUrl: "https://i.imgur.com/BoN9kdC.png"),
      GroupModel(title: "Etika dan Profesi", imageUrl: "https://i.imgur.com/BoN9kdC.png"),
      GroupModel(title: "Jaringan Komputer", imageUrl: "https://i.imgur.com/BoN9kdC.png"),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      // Tombol tambah grup (+)
      floatingActionButton: InkWell(
        onTap: () {},
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: Color(0xFFDFFFEA),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, size: 32, color: Colors.black),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // =======================
            // HEADER GRADIENT
            // =======================
            Container(
              height: 85,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4ADE80), Color(0xFF60A5FA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  // Tombol back
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        "Grup Belajar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 48),
                ],
              ),
            ),

            // =======================
            // LIST GRUP BELAJAR
            // =======================
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final g = groups[index];

                  // Warna selang-seling (mirip desain)
                  final bgColor = index % 2 == 0
                      ? const Color(0xFFDFFFEA) // hijau muda
                      : Colors.white; // putih

                  return Container(
                    color: bgColor,
                    margin: const EdgeInsets.symmetric(vertical: 1),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),

                      // FOTO GRUP
                      leading: CircleAvatar(
                        radius: 23,
                        backgroundImage: NetworkImage(g.imageUrl),
                      ),

                      // NAMA GRUP
                      title: Text(
                        g.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      trailing: const Icon(Icons.more_vert, color: Colors.green),

                      // =======================
                      // ON TAP → MASUK KE CHAT ROOM
                      // =======================
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatRoomPage(groupName: g.title),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
