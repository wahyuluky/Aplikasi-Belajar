import 'package:get/get.dart';

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

  // sample data awal
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

  void addTask(TodoItem item) {
    todos.add(item);
  }
}