import 'package:bread_app/screens/bakers_percentage_screen.dart';
import 'package:bread_app/screens/record_bake_screen.dart';
import 'package:bread_app/screens/save_tips_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BakersPercentageScreen(),
                ),
              );
            },
            icon: const Icon(Icons.calculate),
            label: const Text("Calculate Baker's Percentage"),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecordBakeScreen(),
                ),
              );
            },
            icon: const Icon(Icons.camera),
            label: const Text("Record Your Bake"),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SaveTipsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.lightbulb),
            label: const Text("Save Tips"),
          ),
        ],
      ),
    );
  }
}
