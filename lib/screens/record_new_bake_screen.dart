import 'package:bread_app/utils/db_insert_helper.dart';
import 'package:bread_app/utils/text_field_helper.dart';
import 'package:bread_app/widgets/custom/scaffold.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:flutter/material.dart';

import '../widgets/custom/title.dart';

class RecordNewBakeScreen extends StatelessWidget {
  RecordNewBakeScreen({super.key});

  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextController.setController(_notesController, _notesController.text);

    return CustomScaffold(
      showBackButton: true,
      child: Column(
        children: [
          const CustomTitle(
            icon: Icons.bakery_dining_rounded,
            text: "Add New Record",
          ),
          const CustomSizedBox(),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(labelText: "Notes"),
            maxLines: 10,
          ),
          const CustomSizedBox(),
          ElevatedButton(
            onPressed: () async {
              await DbInsertHelper().insertRecord(
                _notesController.text,
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
