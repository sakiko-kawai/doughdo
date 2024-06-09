import 'package:bread_app/screens/record/record_screen.dart';
import 'package:bread_app/utils/db_helper.dart';
import 'package:bread_app/utils/image_helper.dart';
import 'package:bread_app/widgets/custom/card.dart';
import 'package:bread_app/widgets/custom/scaffold.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:bread_app/widgets/custom/title.dart';
import 'package:bread_app/models/record.dart';
import 'package:bread_app/widgets/record/record_load_image.dart';
import 'package:flutter/material.dart';

import 'record_create_screen.dart';

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
                  builder: (context) => const RecordCreateScreen(),
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
                      child: Row(
                        children: [
                          if (record.thumbnail != null)
                            LoadImage(
                              path: record.thumbnail!.imagePath,
                              size: ImageHelper.thumbnailSize,
                            ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                record.title.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(
                                width: 180,
                                child: Text(
                                  record.notes.notes,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                            ],
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
