import 'package:bread_app/utils/db_helper.dart';
import 'package:bread_app/widgets/custom/card.dart';
import 'package:bread_app/models/record.dart';
import 'package:flutter/material.dart';

class RecordOverview extends StatefulWidget {
  const RecordOverview({super.key});

  @override
  State<RecordOverview> createState() => _RecordOverviewState();
}

class _RecordOverviewState extends State<RecordOverview> {
  List<Record> records = [];
  @override
  void initState() {
    super.initState();
    fetchRecordSetState();
  }

  fetchRecordSetState() async {
    var fetchedData = await DbHelper().getAllRecords();
    fetchedData
        .sort((a, b) => b.createdAt.createdAt.compareTo(a.createdAt.createdAt));
    setState(() {
      records = fetchedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: records
          .map((record) => CustomCard(
                child: Text(record.notes.notes),
              ))
          .toList(),
    );
  }
}
