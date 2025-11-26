import 'package:flutter/material.dart';
import 'pages/group/group_page.dart';   // pastikan path sesuai project kamu

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
      title: 'Aplikasi Belajar',
      home: const GroupPage(),
    );
  }
}
