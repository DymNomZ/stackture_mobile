import 'package:flutter/material.dart';
import 'package:stackture_mobile/auth_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stackture',
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}