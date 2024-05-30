import 'dart:io';
import 'package:bread_app/screens/record/record_overview_screen.dart';
import 'package:bread_app/utils/db_helper.dart';
import 'package:bread_app/utils/image_helper.dart';
import 'package:bread_app/utils/text_field_helper.dart';
import 'package:bread_app/widgets/custom/scaffold.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/custom/title.dart';

class RecordCreateScreen extends StatefulWidget {
  const RecordCreateScreen({super.key});

  @override
  State<RecordCreateScreen> createState() => _RecordCreateScreenState();
}

class _RecordCreateScreenState extends State<RecordCreateScreen> {
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  List<XFile>? images;

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
          if (images == null || images!.isEmpty)
            IconButton(
              onPressed: () async {
                var pickedFiles = await ImageHelper().pickMultiImage();
                setState(() {
                  images = pickedFiles;
                });
              },
              icon: const Icon(Icons.add_a_photo),
            ),
          if (images != null && images!.isNotEmpty)
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List<Widget>.generate(
                  images!.length,
                  (index) => Row(
                    children: [
                      Image.file(
                        File(images![index].path),
                        height: 150,
                      ),
                      const CustomSizedBox(),
                      if (index == images!.length - 1)
                        IconButton(
                          onPressed: () async {
                            var pickedFiles =
                                await ImageHelper().pickMultiImage();
                            setState(() {
                              images = pickedFiles;
                            });
                          },
                          icon: const Icon(Icons.add_a_photo),
                        ),
                    ],
                  ),
                ),
              ),
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
                images,
                images?[0],
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
