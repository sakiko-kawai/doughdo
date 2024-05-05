import 'package:bread_app/screens/bakers_percentage_screen.dart';
import 'package:bread_app/utils/db_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyBreadApp());

  await DbHelper().database;
}

class MyBreadApp extends StatelessWidget {
  const MyBreadApp({super.key});

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
      home: const BakersPercentageScreen(),
    );
  }
}
