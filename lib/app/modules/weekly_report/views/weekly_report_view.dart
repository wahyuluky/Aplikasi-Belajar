import 'package:flutter/material.dart';

class WeeklyReportView extends StatelessWidget {
  const WeeklyReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9BD3FF), Color(0xFF83F68B)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white24,
                        child: Icon(Icons.arrow_back_ios_new,
                            size: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Weekly Report",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // WEEK INFO
              Row(
                children: const [
                  Text("Week : ",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Text("Okt 1 - Okt 7", style: TextStyle(color: Colors.grey)),
                ],
              ),

              const SizedBox(height: 20),

              // PRODUCTIVITY TITLE
              const Text(
                "Productivity",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),

              const SizedBox(height: 16),

              // BAR CHART WRAPPER (improved UI)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FFFA),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 160,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _buildBars(),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // INSIGHTS
              const Text(
                "Insights",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDE9C7),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    "Keren! Kamu telah menyelesaikan 5 materi dalam minggu ini",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // CHECKLIST ITEMS
              _buildChecklist("Kamu telah menyelesaikan: \"Pra Skripsi\""),
              const SizedBox(height: 16),
              _buildChecklist(
                  "Kamu menyelesaikan latihan: \"Membaca Sandi Semaphore\"")
            ],
          ),
        ),
      ),
    );
  }

  // BAR CHART WIDGET
  List<Widget> _buildBars() {
    final barHeights = [40.0, 55.0, 70.0, 85.0, 100.0, 120.0];

    return barHeights.map((h) {
      return Container(
        width: 26,
        height: h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFFB6FFD0), Color(0xFF85F68B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(40, 133, 246, 139),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
      );
    }).toList();
  }

  // CHECKLIST WIDGET
  Widget _buildChecklist(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFFE8FDEB),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green.shade300),
          ),
          child: const Icon(Icons.check, color: Colors.green, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
        )
      ],
    );
  }
}
