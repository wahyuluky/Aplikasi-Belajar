import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  final String groupName;     // Nama grup dari GroupPage
  const ChatRoomPage({super.key, required this.groupName});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class MateriModel {
  final String title;
  final String fileType; // pdf, docx, error, dll
  MateriModel({required this.title, required this.fileType});
}

class MemberModel {
  final String name;
  final String imageUrl;

  MemberModel({required this.name, required this.imageUrl});
}

class _ChatRoomPageState extends State<ChatRoomPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // =======================
            // HEADER GRADIENT
            // =======================
            Container(
              height: 95,
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
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),

                  Expanded(
                    child: Center(
                      child: Text(
                        widget.groupName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.people_alt,
                        color: Colors.white, size: 24),
                  ),
                ],
              ),
            ),

            // =======================
            // TAB MENU (DISKUSI, MATERI, ANGGOTA)
            // =======================
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.green,
                indicatorWeight: 4,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "DISKUSI"),
                  Tab(text: "MATERI"),
                  Tab(text: "ANGGOTA"),
                ],
              ),
            ),

            // =======================
            // TAB VIEW (ISI)
            // =======================
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  chatViewUI(),
                  materiViewUI(),
                  anggotaViewUI(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =======================
  // DISKUSI (Chat Room)
  // =======================
  Widget chatViewUI() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              // Pesan dari orang lain
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://i.imgur.com/BoN9kdC.png",
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jauza:",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87)),
                        SizedBox(height: 4),
                        Text("Deadline tugas kamu bisa dilihat di menu Jadwal Tugas ya"),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Pesan user sendiri
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFFFEA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Nabila",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        Text("Kapan deadline tugas saya?"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://i.imgur.com/BoN9kdC.png",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        chatInputBar(),
      ],
    );
  }

  // =======================
  // MATERI
  // =======================
Widget materiViewUI() {
  // Dummy data materi
  final List<MateriModel> materiList = [
    MateriModel(title: "Pertemuan 1_Rekayasa Interaksi", fileType: "pdf"),
    MateriModel(title: "Pertemuan 2_Rekayasa Interaksi", fileType: "error"),
    MateriModel(title: "Pertemuan 3_Rekayasa Interaksi", fileType: "pdf"),
    MateriModel(title: "Pertemuan 4_Rekayasa Interaksi", fileType: "error"),
    MateriModel(title: "Pertemuan 5_Rekayasa Interaksi", fileType: "pdf"),
  ];

  return ListView.builder(
    itemCount: materiList.length,
    itemBuilder: (context, index) {
      final item = materiList[index];

      // Warna selang-seling (PUTIH → HIJAU → PUTIH → HIJAU)
      final bgColor = index % 2 == 0
          ? Colors.white
          : const Color(0xFFDFFFEA);

      // Tentukan warna ikon
      IconData icon = Icons.insert_drive_file;
      Color iconColor =
          item.fileType == "pdf" ? Colors.blue : Colors.red;

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        color: bgColor,
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}


  // =======================
  // ANGGOTA
  // =======================
Widget anggotaViewUI() {
  // Dummy data anggota
  final List<MemberModel> members = [
    MemberModel(
      name: "Putri Nabila",
      imageUrl: "https://i.imgur.com/7Q0p3eS.png",
    ),
    MemberModel(
      name: "Ernaya Fitri",
      imageUrl: "https://i.imgur.com/XnX6f6f.png",
    ),
    MemberModel(
      name: "Nadra Tan",
      imageUrl: "https://i.imgur.com/bDg4Yx2.png",
    ),
    MemberModel(
      name: "Wahyu Lukytaningtyas",
      imageUrl: "https://i.imgur.com/LK7ZC3O.png",
    ),
    MemberModel(
      name: "Jauza Wijdaniah",
      imageUrl: "https://i.imgur.com/BoN9kdC.png",
    ),
  ];

  return Stack(
    children: [
      ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: members.length,
        itemBuilder: (context, index) {
          final m = members[index];

          // Warna selang-seling sama seperti screenshot
          final bgColor = index % 2 == 0
              ? Colors.white
              : const Color(0xFFDFFFEA);

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: bgColor,
            child: Row(
              children: [
                // Profile image
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(m.imageUrl),
                ),

                const SizedBox(width: 12),

                // Name
                Text(
                  m.name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          );
        },
      ),

      // Floating + button (untuk tambah anggota)
      Positioned(
        bottom: 16,
        right: 16,
        child: InkWell(
          onTap: () {
            // nanti: buka halaman tambah anggota
          },
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
      ),
    ],
  );
}

  // =======================
  // INPUT CHAT BAR
  // =======================
  Widget chatInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Icon media / dokumen
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.attach_file, color: Colors.black),
          ),

          const SizedBox(width: 10),

          // Text field
          Expanded(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _msgController,
                decoration: const InputDecoration(
                    hintText: "Ketik Pesan", border: InputBorder.none),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Kamera
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.camera_alt_outlined, color: Colors.black),
          ),

          const SizedBox(width: 10),

          // Voice
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Color(0xFFDFFFEA),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mic, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
