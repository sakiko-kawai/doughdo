import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:bread_app/widgets/record/record_edit_image.dart';
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
  List<XFile> images = List.empty(growable: true);

  Future<void> pickAndCropImage() async {
    var pickedFiles = await ImageHelper().pickMultiImage();
    List<XFile> croppedImages = List.empty(growable: true);
    if (pickedFiles != null) {
      for (var file in pickedFiles) {
        CroppedFile? croppedImage =
            await ImageHelper().cropImage(file, context);
        croppedImages.add(XFile(croppedImage!.path));
      }
    }

    setState(() {
      for (var img in croppedImages) {
        images.add(img);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextController.setController(_notesController, _notesController.text);
    TextController.setController(_titleController, _titleController.text);

    Future<void> onSave() async {
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
    }

    List<Widget> imageWidgets = List.empty(growable: true);
    void setImageWidgets() {
      if (images.isNotEmpty) {
        for (var img in images) {
          imageWidgets.add(EditImage(
            imageWidget: Image.file(
              File(img.path),
              height: 150,
            ),
            onDelete: () {
              setState(() {
                images.remove(img);
              });
            },
          ));
        }
      }
      imageWidgets.add(Card.outlined(
        child: SizedBox(
          width: 150,
          height: 150,
          child: IconButton(
            onPressed: () {
              pickAndCropImage();
            },
            icon: const Icon(Icons.add_a_photo),
          ),
        ),
      ));
    }

    setImageWidgets();

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
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageWidgets.length,
              itemBuilder: (context, index) {
                return imageWidgets[index];
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
              await onSave();
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }
}
