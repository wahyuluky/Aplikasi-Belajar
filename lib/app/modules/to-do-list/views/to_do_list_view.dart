import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/to_do_list_controller.dart';

class TodoView extends GetView<TodoController> {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do-List'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.todos.length,
                  itemBuilder: (context, index) {
                    final item = controller.todos[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // checkbox
                          Obx(() => Checkbox(
                                value: item.isDone.value,
                                onChanged: (_) => controller.toggleCheck(index),
                              )),

                          // text informasi
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${item.description} | ${item.date}",
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),

                          // tombol edit & hapus
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () => controller.deleteTask(index),
                                child: Row(
                                  children: [
                                    const Icon(Icons.delete, color: Colors.red, size: 16),
                                    const SizedBox(width: 4),
                                    const Text(
                                      "Hapus",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () {
                                  // nanti bisa buat edit page
                                },
                                child: Row(
                                  children: const [
                                    Icon(Icons.edit, size: 16),
                                    SizedBox(width: 4),
                                    Text("Edit"),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              }),
            ),

            // input tambah tugas
            TextField(
              decoration: InputDecoration(
                hintText: "Tambahkan tugas",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  controller.addTask(
                    TodoItem(
                      title: value,
                      description: "Deskripsi",
                      date: "Belum diatur",
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
