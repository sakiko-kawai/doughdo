import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyBreadApp());
}

class MyBreadApp extends StatelessWidget {
  const MyBreadApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Bread App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          constraints: BoxConstraints(maxWidth: 300),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
