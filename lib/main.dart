import 'package:flutter/material.dart';
import 'package:helmsman_practical/Screens/Login_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Practical',
      theme: ThemeData(
        primaryColor: const Color(0xFF673AB7),
        // useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(secondary: const Color(0xFFFFC107)),
      ),
      home: LoginPage(),
    );
  }
}
