import 'package:bread_app/screens/bakers_percentage_screen.dart';
import 'package:bread_app/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://dwgmzsnquakzdzcvxmxh.supabase.co';
const supabaseKey = String.fromEnvironment('SUPABASE_KEY');

void main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  await SpHelper().prefs;
  runApp(const MyBreadApp());
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
          constraints: BoxConstraints(maxWidth: 500),
        ),
      ),
      home: const BakersPercentageScreen(),
    );
  }
}
