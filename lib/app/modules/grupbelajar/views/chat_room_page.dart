import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  final String groupName;     // Nama grup dari GroupPage
  const ChatRoomPage({super.key, required this.groupName});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
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
    return const Center(
      child: Text("Belum ada materi", style: TextStyle(color: Colors.grey)),
    );
  }

  // =======================
  // ANGGOTA
  // =======================
  Widget anggotaViewUI() {
    return const Center(
      child: Text("Daftar Anggota Grup", style: TextStyle(color: Colors.grey)),
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
