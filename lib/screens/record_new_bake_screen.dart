import 'package:bread_app/utils/db_insert_helper.dart';
import 'package:bread_app/widgets/custom/custom_scaffold.dart';
import 'package:bread_app/widgets/custom/custom_sized_box.dart';
import 'package:flutter/material.dart';

import '../widgets/custom/custom_title.dart';

class RecordNewBakeScreen extends StatelessWidget {
  const RecordNewBakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const CustomTitle(
            icon: Icons.bakery_dining_rounded,
            text: "Add New Record",
          ),
          const CustomSizedBox(),
          const TextField(
            decoration: InputDecoration(labelText: "Notes"),
            maxLines: 10,
          ),
          const CustomSizedBox(),
          ElevatedButton(
            onPressed: () async {
              await DbInsertHelper().insertRecord(
                "this is notes",
                DateTime.now().toIso8601String(),
                DateTime.now().toIso8601String(),
              );
              debugPrint('one record inserted');
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }
}
