import 'package:bread_app/widgets/custom/custom_scaffold.dart';
import 'package:bread_app/widgets/custom/custom_title.dart';
import 'package:flutter/material.dart';

import 'record_new_bake_screen.dart';

class RecordBakeScreen extends StatelessWidget {
  const RecordBakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const CustomTitle(
            icon: Icons.bookmark_border_rounded,
            text: "Record your Bake!",
          ),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecordNewBakeScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add_outlined),
            label: const Text("Add a new record"),
          )
        ],
      ),
    );
  }
}
