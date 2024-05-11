import 'package:bread_app/screens/record/record_overview_screen.dart';
import 'package:bread_app/utils/db_helper.dart';
import 'package:bread_app/utils/text_field_helper.dart';
import 'package:bread_app/widgets/custom/scaffold.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom/title.dart';

class RecordCreateScreen extends StatelessWidget {
  RecordCreateScreen({super.key});

  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextController.setController(_notesController, _notesController.text);
    TextController.setController(_titleController, _titleController.text);

    return CustomScaffold(
      showBackButton: true,
      onTapBackButton: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RecordOverviewScreen(),
          ),
        );
      },
      child: Column(
        children: [
          const CustomTitle(
            icon: Icons.bakery_dining_rounded,
            text: "Add New Record",
          ),
          const CustomSizedBox(),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: "Title"),
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
              await DbHelper().insertRecord(
                _titleController.text,
                _notesController.text,
              );
              debugPrint('one record inserted');

              if (!context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecordOverviewScreen(),
                ),
              );
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }
}
