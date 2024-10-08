import 'package:bread_app/screens/record/record_edit_screen.dart';
import 'package:bread_app/screens/record/record_overview_screen.dart';
import 'package:bread_app/utils/db_helper.dart';
import 'package:bread_app/utils/image_helper.dart';
import 'package:bread_app/widgets/custom/scaffold.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:bread_app/models/record.dart';
import 'package:bread_app/widgets/custom/delete_dialog.dart';
import 'package:bread_app/widgets/record/record_load_image.dart';
import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  final Record record;
  const RecordScreen({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final List<String>? paths = record.images?.imagePaths;

    void onDelete() {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => DeleteDialog(
                onConfirm: () async {
                  await DbHelper().deleteRecord(record.recordId!.id);

                  if (!context.mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecordOverviewScreen(),
                    ),
                  );
                },
                text: 'Are you sure you want to delete this record?',
              ));
    }

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
                    onDelete();
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
          if (record.images != null)
            SizedBox(
              height: ImageHelper.imageSize.toDouble(),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: paths!.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      LoadImage(
                        path: paths[index],
                        size: ImageHelper.imageSize,
                      ),
                      const CustomSizedBox(),
                    ],
                  );
                },
              ),
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
