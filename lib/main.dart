import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/weekly_report/views/weekly_report_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Focus App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const WeeklyReportView(), // ⬅ HALAMAN AWAL DIUBAH KE FOCUS MODE
    );
  }
}
