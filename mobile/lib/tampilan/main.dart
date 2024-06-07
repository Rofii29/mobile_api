// main.dart

import 'package:flutter/material.dart';

import 'package:mobile/tampilan/login..dart';
// import 'beranda.dart'; // Import file home.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Gunakan HomeScreen dari home.dart
    );
  }
}
