import 'dart:io';

import 'package:bread_app/screens/record/record_edit_screen.dart';
import 'package:bread_app/screens/record/record_overview_screen.dart';
import 'package:bread_app/widgets/custom/scaffold.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:bread_app/models/record.dart';
import 'package:bread_app/widgets/record_delete_dialog.dart';
import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  final Record record;
  const RecordScreen({Key? key, required this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_note_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordEditScreen(record: record),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => RecordDeleteDialog(
                              recordId: record.recordId!.id,
                            ));
                  },
                ),
              ],
            ),
          ),
          const CustomSizedBox(),
          Text(
            record.title.title,
            style: const TextStyle(fontSize: 22),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          const CustomSizedBox(),
          if (record.image != null)
            Image.file(
              File(record.image!.imagePath),
              height: 250,
            ),
          const CustomSizedBox(),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 2000),
            child: Text(record.notes.notes),
          ),
        ],
      ),
    );
  }
}
