import 'package:bread_app/widgets/custom/card.dart';
import 'package:bread_app/widgets/custom/scaffold.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:bread_app/widgets/custom/title.dart';
import 'package:bread_app/models/record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecordScreen extends StatelessWidget {
  final Record record;
  const RecordScreen({Key? key, required this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackButton: true,
      onTapBackButton: () => Navigator.pop(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            record.title.title,
            style: const TextStyle(fontSize: 22),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
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
