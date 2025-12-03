import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/koleksi_musik/views/koleksi_musik_view.dart';
 // pastikan path sesuai project Anda

class FocusModeView extends StatelessWidget {
  const FocusModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // =======================
          // APPBAR GRADIENT CUSTOM
          // =======================
          Container(
            padding:
                const EdgeInsets.only(top: 45, left: 10, right: 10, bottom: 15),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7BC6FF), Color(0xFF2CE58D)],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                const Spacer(),
                const Text(
                  "Focus Mode",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                const SizedBox(width: 20),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // =======================
          // PROGRESS BAR CUSTOM
          // =======================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF64D883), width: 3),
              ),
              child: Row(
                children: List.generate(
                  18,
                  (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 1.5, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF64D883),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          const SizedBox(
            height: 180,
            width: 180,
            child: Center(
              child: Text(
                "🙂",
                style: TextStyle(
                  fontSize: 120,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Ayo Istirahat",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            "Kamu sudah fokus selama 25 menit",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 100),

          // =======================
          // BUTTON PLAY
          // =======================
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: SizedBox(
              width: 260,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // ==============================
                  // ➤ Navigasi ke Koleksi Musik
                  // ==============================
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KoleksiMusikView(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF47E06C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Play Relaxing Music",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
