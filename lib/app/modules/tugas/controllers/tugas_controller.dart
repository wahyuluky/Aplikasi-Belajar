import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'tugas_model.dart';
import 'package:intl/intl.dart';

class TugasController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<TugasModel> listTugas = <TugasModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    ambilTugas();
  }

  // 🔥 READ realtime
  void ambilTugas() {
    firestore
        .collection('tugas')
        .orderBy('created_at', descending: true)
        .snapshots()
        .listen((snapshot) {
      listTugas.value = snapshot.docs
          .map((doc) =>
              TugasModel.fromFirestore(doc.id, doc.data()))
          .toList();
    });
  }

  // ✔ checkbox
  void toggleCheck(TugasModel tugas) async {
    await firestore.collection('tugas').doc(tugas.id).update({
      'isDone': !tugas.isDone,
    });
  }

  // 🗑 delete
  void hapusTugas(String id) async {
    await firestore.collection('tugas').doc(id).delete();
  }

  // 📅 formatter
  String formatTanggal(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
}
