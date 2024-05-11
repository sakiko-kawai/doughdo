import 'package:bread_app/screens/record/record_overview_screen.dart';
import 'package:bread_app/screens/record/record_screen.dart';
import 'package:bread_app/utils/db_helper.dart';
import 'package:bread_app/utils/text_field_helper.dart';
import 'package:bread_app/widgets/custom/scaffold.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:bread_app/widgets/custom/title.dart';
import 'package:bread_app/models/record.dart';
import 'package:flutter/material.dart';

class RecordEditScreen extends StatefulWidget {
  final Record record;
  const RecordEditScreen({Key? key, required this.record}) : super(key: key);

  @override
  State<RecordEditScreen> createState() => _RecordEditScreenState();
}

class _RecordEditScreenState extends State<RecordEditScreen> {
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.record.notes.notes;
    _titleController.text = widget.record.title.title;
  }

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
            text: "Edit Record",
          ),
          const CustomSizedBox(),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: "Title"),
            onChanged: (value) {
              _titleController.text = value;
            },
          ),
          const CustomSizedBox(),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(labelText: "Notes"),
            maxLines: 10,
            onChanged: (value) {
              _notesController.text = value;
            },
          ),
          const CustomSizedBox(),
          ElevatedButton(
            onPressed: () async {
              await DbHelper().updateRecord(
                widget.record.recordId!.id,
                _titleController.text,
                _notesController.text,
                widget.record.createdAt,
              );
              debugPrint('one record edited');

              var updatedRecord =
                  await DbHelper().getRecordById(widget.record.recordId!);
              if (!context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordScreen(
                    record: updatedRecord,
                  ),
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
