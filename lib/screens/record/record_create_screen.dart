import 'dart:typed_data';

import 'package:bread_app/models/image.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img;
import 'package:bread_app/screens/record/record_overview_screen.dart';
import 'package:bread_app/utils/db_helper.dart';
import 'package:bread_app/utils/image_helper.dart';
import 'package:bread_app/utils/text_field_helper.dart';
import 'package:bread_app/widgets/custom/scaffold.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:flutter/material.dart' hide Image;

import '../../widgets/custom/title.dart';

class RecordCreateScreen extends StatefulWidget {
  const RecordCreateScreen({super.key});

  @override
  State<RecordCreateScreen> createState() => _RecordCreateScreenState();
}

class _RecordCreateScreenState extends State<RecordCreateScreen> {
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  List<CustomImage> images = List.empty(growable: true);

  Future<void> pickAndCropImage() async {
    var pickedFiles = await ImageHelper().pickMultiImage();
    List<CustomImage> croppedImages = List.empty(growable: true);
    if (pickedFiles != null) {
      for (var file in pickedFiles) {
        var croppedImage = await ImageHelper().cropImage(file, false);
        croppedImages.add(CustomImage(pickedImage: file, image: croppedImage));
      }
    }

    setState(() {
      images = croppedImages;
    });
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
            text: "Add New Record",
          ),
          const CustomSizedBox(),
          if (images.isEmpty) //TODO: separate in different widget
            IconButton(
              onPressed: () async {
                await pickAndCropImage();
              },
              icon: const Icon(Icons.add_a_photo),
            ),
          if (images.isNotEmpty)
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Row(children: [
                    if (images[index].image != null)
                      Image.memory(
                        Uint8List.fromList(img.encodePng(images[index].image!)),
                        height: 150,
                      ),
                    const CustomSizedBox(),
                  ]);
                },
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
                images.isEmpty ? null : images,
                images.isEmpty ? null : images[0],
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
