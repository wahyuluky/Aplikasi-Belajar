class TugasModel {
  String id;
  String judul;
  String deskripsi;
  String tanggal;
  bool isDone;

  TugasModel({
    this.id = "",
    required this.judul,
    required this.deskripsi,
    required this.tanggal,
    this.isDone = false,
  });

  factory TugasModel.fromMap(String id, Map<String, dynamic> data) {
    return TugasModel(
      id: id,
      judul: data['judul'] ?? "",
      deskripsi: data['deskripsi'] ?? "",
      tanggal: data['tanggal'] ?? "",
      isDone: data['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "judul": judul,
      "deskripsi": deskripsi,
      "tanggal": tanggal,
      "isDone": isDone,
    };
  }

}
