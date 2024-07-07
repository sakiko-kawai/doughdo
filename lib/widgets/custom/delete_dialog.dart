import 'package:bread_app/models/color.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final void Function()? onConfirm;
  final String text;
  const DeleteDialog({super.key, required this.onConfirm, required this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            const SizedBox(height: 15),
            Row(
              children: [
                TextButton(
                  onPressed: onConfirm,
                  child: Text(
                    'Delete',
                    style: TextStyle(color: DoughdoColor().error),
                  ),
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
