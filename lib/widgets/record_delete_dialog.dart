import 'package:bread_app/screens/record/record_overview_screen.dart';
import 'package:bread_app/utils/db_helper.dart';
import 'package:flutter/material.dart';

class RecordDeleteDialog extends StatelessWidget {
  final int recordId;
  const RecordDeleteDialog({Key? key, required this.recordId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Are you sure you want to delete this record?'),
            const SizedBox(height: 15),
            Row(
              children: [
                TextButton(
                  onPressed: () async {
                    await DbHelper().deleteRecord(recordId);

                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecordOverviewScreen(),
                      ),
                    );
                  },
                  child: const Text('Delete'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
