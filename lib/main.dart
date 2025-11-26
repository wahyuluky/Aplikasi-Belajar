import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_application_1/app/modules/weekly_report/views/weekly_report_view.dart';

void main() {
=======
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
>>>>>>> e4697a5b47fa6d87f880c76bd49dbf3a62b87234
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      title: 'Focus App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const WeeklyReportView(), // ⬅ HALAMAN AWAL DIUBAH KE FOCUS MODE
=======
      title: "Aplikasi Belajar",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
>>>>>>> e4697a5b47fa6d87f880c76bd49dbf3a62b87234
    );
  }
}
