import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/schedule/controllers/schedule_controller.dart';
import 'package:flutter_application_1/app/modules/schedule/models/schedule_models.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Tambahkan intl ke pubspec.yaml
import 'package:table_calendar/table_calendar.dart'; 

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller sudah tersedia via GetView<JadwalController>
    final controller = Get.find<ScheduleController>();

    return Scaffold(
      // App Bar dengan gradient background (seperti gambar)
      appBar: AppBar(
        title: const Text('Jadwal', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF81C784), // Hijau muda
                Color(0xFF4DB6AC), // Tosca muda
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      // Body utama
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Bagian Kalender
            _buildCalendar(controller),
            
            // Separator
            const SizedBox(height: 10),
            const Divider(height: 1, thickness: 1),

            // 2. Bagian Daftar Jadwal
            _buildScheduleList(controller),
          ],
        ),
      ),
      // Bottom Navigation Bar sederhana (sesuai gambar)
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  // --- WIDGET BAGIAN KALENDER ---
  Widget _buildCalendar(ScheduleController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        return Column(
          children: [
            // Header Bulan dan Tahun (Oktober 2025)
            _buildMonthYearHeader(controller.selectedDate.value),
            
            // Table Calendar
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: controller.selectedDate.value,
              currentDay: controller.selectedDate.value, // Untuk menandai hari ini jika perlu
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.sunday, // Minggu sebagai hari pertama

              // Style Calendar
              headerVisible: false, // Menyembunyikan header default TableCalendar
              daysOfWeekHeight: 25.0,
              rowHeight: 40.0,
              
              calendarStyle: CalendarStyle(
                // Mengatur tampilan hari terpilih
                selectedDecoration: const BoxDecoration(
                  color: Colors.red, // Warna merah sesuai gambar
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                // Mengatur tampilan hari dengan jadwal (jika ada)
                markerDecoration: const BoxDecoration(
                  color: Colors.green, // Contoh warna marker
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: const TextStyle(color: Colors.grey),
                // Mengatur nama hari (Sen, Sel, Rab, dst)
                defaultTextStyle: const TextStyle(color: Colors.black),
              ),

              // Mengatur nama hari (Min, Sen, Sel, dst)
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                weekendStyle: TextStyle(fontWeight: FontWeight.bold),
                // shortNames: true, // Menggunakan Min, Sen, Sel, dst.
              ),
              
              // Event Builder untuk menandai tanggal dengan jadwal
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  // Cek apakah ada jadwal di hari ini
                  final hasSchedule = controller.hasScheduleOnDate(day);
                  
                  if (isSameDay(day, controller.selectedDate.value)) {
                    // Tampilan hari yang terpilih
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    );
                  } else if (hasSchedule) {
                    // Tampilan hari yang memiliki jadwal (tanpa terpilih)
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 1), // Border hijau
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  
                  // Tampilan hari normal
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),

              // Aksi saat tanggal di-tap
              onDaySelected: (selectedDay, focusedDay) {
                // Pastikan fokus tetap di bulan yang sama jika tidak ada perubahan bulan
                if (!isSameDay(controller.selectedDate.value, selectedDay)) {
                  controller.setSelectedDate(selectedDay);
                }
              },
            ),
          ],
        );
      }),
    );
  }

  // Header "Oktober 2025" dengan tombol panah
  Widget _buildMonthYearHeader(DateTime selectedDate) {
  // Ambil instance controller
  final controller = Get.find<ScheduleController>();
  
  final dateFormat = DateFormat('MMMM yyyy', 'id_ID'); 
  final monthYearText = dateFormat.format(selectedDate);
  
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Tombol BULAN SEBELUMNYA
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 16),
          onPressed: () {
            // Logika pindah ke bulan sebelumnya
            final previousMonth = DateTime(
              selectedDate.year, 
              selectedDate.month - 1, // Kurangi 1 bulan
              selectedDate.day.clamp(1, DateUtils.getDaysInMonth(selectedDate.year, selectedDate.month - 1)),
            );
            controller.setSelectedDate(previousMonth);
          },
        ),
        
        // Teks Bulan dan Tahun
        Obx(() {
          // Gunakan Obx agar teks ini otomatis update saat selectedDate di controller berubah
          final currentDisplayDate = controller.selectedDate.value;
          final currentMonthYearText = dateFormat.format(currentDisplayDate);
          
          return Text(
            currentMonthYearText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          );
        }),
        
        // Tombol BULAN SELANJUTNYA
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios, size: 16),
          onPressed: () {
            // Logika pindah ke bulan selanjutnya
            final nextMonth = DateTime(
              selectedDate.year, 
              selectedDate.month + 1, // Tambah 1 bulan
              selectedDate.day.clamp(1, DateUtils.getDaysInMonth(selectedDate.year, selectedDate.month + 1)),
            );
            controller.setSelectedDate(nextMonth);
          },
        ),
      ],
    ),
  );
}

  // --- WIDGET BAGIAN DAFTAR JADWAL ---
  Widget _buildScheduleList(ScheduleController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Jadwal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Tombol Tambah Jadwal (+)
              IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () => Get.to(() => _AddJadwalScreen()),
              ),
            ],
          ),
        ),
        
        // Daftar Jadwal yang difilter
        Obx(() {
          final schedules = controller.filteredSchedules;
          if (schedules.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Tidak ada jadwal di tanggal ini.'),
            );
          }
          
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Menonaktifkan scroll di ListView
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              final jadwal = schedules[index];
              return _buildJadwalItem(controller, jadwal);
            },
          );
        }),
      ],
    );
  }
  
  // Item tunggal Jadwal (sesuai gambar: Pra Skripsi)
  Widget _buildJadwalItem(ScheduleController controller, Schedule jadwal) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // Warna hijau muda sesuai gambar
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Kiri: Mata Pelajaran & Tanggal
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jadwal.mataKuliah,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                dateFormat.format(jadwal.tanggal),
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          
          // Kanan: Tombol Hapus & Edit
          Row(
            children: [
              // Tombol Hapus
              GestureDetector(
                onTap: () => controller.deleteJadwal(jadwal.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Hapus',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Tombol Edit
              GestureDetector(
                onTap: () => Get.to(() => _EditJadwalScreen(jadwal: jadwal)),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF81C784), // Warna hijau muda
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- WIDGET BOTTOM NAV BAR ---
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavBarItem(icon: Icons.home, label: 'Home', isSelected: false),
            _NavBarItem(icon: Icons.calendar_today, label: 'Jadwal', isSelected: true),
            _NavBarItem(icon: Icons.assignment, label: 'Tugas', isSelected: false),
            _NavBarItem(icon: Icons.bar_chart, label: 'Report', isSelected: false),
            _NavBarItem(icon: Icons.person, label: 'Profil', isSelected: false),
          ],
        ),
      ),
    );
  }
}

// Widget untuk item Bottom Nav Bar
class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? const Color(0xFF4DB6AC) : Colors.grey.shade600;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 10),
        ),
      ],
    );
  }
}

// =========================================================================
// WIDGET SCREEN TAMBAH JADWAL (Sesuai Gambar 2)
// =========================================================================

class _AddJadwalScreen extends StatefulWidget {
  @override
  _AddJadwalScreenState createState() => _AddJadwalScreenState();
}

class _AddJadwalScreenState extends State<_AddJadwalScreen> {
  final controller = Get.find<ScheduleController>();
  final mataPelajaranCtrl = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    mataPelajaranCtrl.dispose();
    super.dispose();
  }
  
  // Fungsi untuk menampilkan date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Jadwal', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF81C784), Color(0xFF4DB6AC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Field Mata Pelajaran
            const Text('Mata Pelajaran', style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 8),
            TextField(
              controller: mataPelajaranCtrl,
              decoration: InputDecoration(
                hintText: 'Tulis disini',
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                fillColor: Colors.grey.shade100,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),

            // Field Tanggal
            const Text('Tanggal', style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null 
                        ? 'DD/MM/YYYY' 
                        : dateFormat.format(selectedDate!),
                      style: TextStyle(
                        color: selectedDate == null ? Colors.grey : Colors.black,
                      ),
                    ),
                    const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Tombol Batal dan Simpan
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Tombol Batal
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  child: const Text('Batal'),
                ),
                const SizedBox(width: 15),
                // Tombol Simpan
                ElevatedButton(
                  onPressed: () {
                    if (mataPelajaranCtrl.text.isNotEmpty && selectedDate != null) {
                      controller.addJadwal(mataPelajaranCtrl.text, selectedDate!);
                    } else {
                      Get.snackbar('Error', 'Harap isi semua kolom', snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4DB6AC), // Hijau/Tosca
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// =========================================================================
// WIDGET SCREEN EDIT JADWAL (Sesuai Gambar 3)
// =========================================================================

class _EditJadwalScreen extends StatefulWidget {
  final Schedule jadwal;

  const _EditJadwalScreen({required this.jadwal});

  @override
  _EditJadwalScreenState createState() => _EditJadwalScreenState();
}

class _EditJadwalScreenState extends State<_EditJadwalScreen> {
  final controller = Get.find<ScheduleController>();
  late TextEditingController mataPelajaranCtrl;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data jadwal yang akan diedit
    mataPelajaranCtrl = TextEditingController(text: widget.jadwal.mataKuliah);
    selectedDate = widget.jadwal.tanggal;
  }
  
  @override
  void dispose() {
    mataPelajaranCtrl.dispose();
    super.dispose();
  }
  
  // Fungsi untuk menampilkan date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Jadwal', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF81C784), Color(0xFF4DB6AC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Field Mata Pelajaran (terisi)
            const Text('Mata Pelajaran', style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 8),
            TextField(
              controller: mataPelajaranCtrl,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                fillColor: Colors.grey.shade100,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),

            // Field Tanggal (terisi)
            const Text('Tanggal', style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateFormat.format(selectedDate),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Tombol Batal dan Simpan
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Tombol Batal
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  child: const Text('Batal'),
                ),
                const SizedBox(width: 15),
                // Tombol Simpan
                ElevatedButton(
                  onPressed: () {
                    if (mataPelajaranCtrl.text.isNotEmpty) {
                      controller.editJadwal(
                        widget.jadwal.id, 
                        mataPelajaranCtrl.text, 
                        selectedDate
                      );
                    } else {
                      Get.snackbar('Error', 'Harap isi semua kolom', snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4DB6AC), // Hijau/Tosca
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}