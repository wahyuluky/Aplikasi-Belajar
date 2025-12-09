class TugasModel {
  String judul;
  String deskripsi;
  String tanggal;
  bool isDone;

  TugasModel({
    required this.judul,
    required this.deskripsi,
    required this.tanggal,
    this.isDone = false,
  });
}
