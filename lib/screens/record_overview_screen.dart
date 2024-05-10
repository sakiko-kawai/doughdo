import 'package:bread_app/screens/record_screen.dart';
import 'package:bread_app/utils/db_helper.dart';
import 'package:bread_app/widgets/custom/card.dart';
import 'package:bread_app/widgets/custom/scaffold.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:bread_app/widgets/custom/title.dart';
import 'package:bread_app/models/record.dart';
import 'package:flutter/material.dart';

import 'record_new_bake_screen.dart';

class RecordOverviewScreen extends StatefulWidget {
  const RecordOverviewScreen({super.key});

  @override
  State<RecordOverviewScreen> createState() => _RecordOverviewScreenState();
}

class _RecordOverviewScreenState extends State<RecordOverviewScreen> {
  List<Record> records = [];
  @override
  void initState() {
    super.initState();
    fetchRecordSetState();
  }

  void fetchRecordSetState() async {
    var fetchedData = await DbHelper().getAllRecords();
    fetchedData
        .sort((a, b) => b.createdAt.createdAt.compareTo(a.createdAt.createdAt));
    setState(() {
      records = fetchedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const CustomTitle(
            icon: Icons.bookmark_border_rounded,
            text: "Record your Bake!",
          ),
          const CustomSizedBox(),
          CustomCard(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordNewBakeScreen(),
                ),
              );
            },
            child: const Icon(Icons.add_outlined),
          ),
          Column(
            children: records
                .map((record) => CustomCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecordScreen(record: record),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            record.title.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            record.notes.notes,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
