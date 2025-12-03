class Schedule {
  final String id; // ID unik untuk operasi edit/hapus
  final String mataKuliah;
  final DateTime tanggal;

  Schedule({
    required this.id,
    required this.mataKuliah,
    required this.tanggal,
  });
}