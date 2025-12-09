import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TodoItem {
  String title;
  String description;
  String date;
  RxBool isDone = false.obs;

  TodoItem({
    required this.title,
    required this.description,
    required this.date,
  });
}

class TodoController extends GetxController {
  RxList<TodoItem> todos = <TodoItem>[].obs;

  @override
  void onInit() {
    todos.addAll([
      TodoItem(
        title: "Etika dan Profesi",
        description: "Kode etik",
        date: "20 Oktober 2025",
      ),
      TodoItem(
        title: "Pra Skripsi",
        description: "Identifikasi topik",
        date: "25 Oktober 2025",
      ),
      TodoItem(
        title: "Rekayasa Interaksi",
        description: "Prototype",
        date: "26 Oktober 2025",
      ),
    ]);
    super.onInit();
  }

  void toggleCheck(int index) {
    todos[index].isDone.value = !todos[index].isDone.value;
  }

  void deleteTask(int index) {
    todos.removeAt(index);
  }

  // ===========================================
  // FUNGSI TAMBAH DATA DENGAN DIALOG
  // ===========================================
  void openAddDialog() {
    final titleC = TextEditingController();
    final descC = TextEditingController();
    final dateC = TextEditingController();

    Get.defaultDialog(
      title: "Tambah To-Do",
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: const InputDecoration(
                hintText: "Judul tugas",
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descC,
              decoration: const InputDecoration(
                hintText: "Deskripsi",
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: dateC,
              decoration: const InputDecoration(
                hintText: "Tanggal",
              ),
            ),
          ],
        ),
      ),
      textConfirm: "Tambah",
      textCancel: "Batal",
      onConfirm: () {
        if (titleC.text.trim().isEmpty) return; // validasi wajib isi

        todos.add(TodoItem(
          title: titleC.text,
          description: descC.text.isEmpty ? "-" : descC.text,
          date: dateC.text.isEmpty ? "-" : dateC.text,
        ));

        Get.back();
      },
    );
  }
}
