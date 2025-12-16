import 'package:cloud_firestore/cloud_firestore.dart';

class TugasModel {
  String id;
  String judul;
  String deskripsi;
  DateTime tanggal;
  bool isDone;

  TugasModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.tanggal,
    required this.isDone,
  });

  factory TugasModel.fromFirestore(
      String id, Map<String, dynamic> data) {
    return TugasModel(
      id: id,
      judul: data['nama_tugas'],
      deskripsi: data['keterangan'],
      tanggal: (data['tanggal'] as Timestamp).toDate(),
      isDone: data['isDone'] ?? false,
    );
  }
}
