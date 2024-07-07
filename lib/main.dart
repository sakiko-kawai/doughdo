import 'package:bread_app/screens/bakers_percentage_screen.dart';
import 'package:bread_app/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? "",
      anonKey: dotenv.env['SUPABASE_KEY'] ?? "");
  await SpHelper().prefs;

  runApp(const DoughdoApp());
}

class DoughdoApp extends StatelessWidget {
  const DoughdoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Bread App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
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
