import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/editschedule/controllers/editschedule_controller.dart';
import 'package:get/get.dart';

class EditscheduleView extends GetView<EditscheduleController> {
  final EditscheduleController c = Get.put(EditscheduleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.white,),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Edit Jadwal",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF74E4A2), Color(0xFF93D8FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
          children: [
            const SizedBox(height: 20),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LABEL
                    const Text(
                      "Mata Pelajaran",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),

                    // INPUT SUBJECT
                    SizedBox(
                      height: 39, // ⬅ tinggi dikurangi
                      child: TextField(
                        style: const TextStyle(fontSize: 12),
                        controller: controller.subjectC,
                        decoration: InputDecoration(
                          hintText: "Tulis disini",
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: EdgeInsets.all(12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),


                    const SizedBox(height: 10),
                    const Text(
                      "Tanggal",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),

                    // INPUT DATE
                    SizedBox(
                      height: 39, // ⬅ tinggi dikurangi
                      child: TextField(
                        style: const TextStyle(fontSize: 12),
                        controller: controller.dateC,
                        decoration: InputDecoration(
                          hintText: "DD/MM/YYYY",
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: EdgeInsets.all(12),
                          suffixIcon: const Icon(Icons.calendar_month, size: 18, color: Colors.grey,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: () async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    firstDate: DateTime(2000),
    lastDate: DateTime(2050),
    initialDate: DateTime.now(),
  );

  if (pickedDate != null) {
    controller.dateC.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
  }
},

                    ),
                  ),

                    const SizedBox(height: 30), // 🔽 tombol tidak terlalu bawah

                    // BUTTONS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // BATAL
                        ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade400,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 10),
                                minimumSize: const Size(74, 39),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Batal",
                              style: TextStyle(fontSize: 14, color: Colors.white)),
                        ),

                        // SIMPAN
                        ElevatedButton(
                          onPressed: () {
                            controller.updateSchedule();
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade500,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 10),
                                minimumSize: const Size(74, 39),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Simpan",
                              style: TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: EditscheduleView(),
  ));
}