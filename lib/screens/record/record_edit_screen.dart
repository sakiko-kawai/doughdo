import 'dart:io';
import 'dart:typed_data';
import 'package:bread_app/models/image.dart';
import 'package:bread_app/screens/record/record_overview_screen.dart';
import 'package:bread_app/screens/record/record_screen.dart';
import 'package:bread_app/utils/db_helper.dart';
import 'package:bread_app/utils/image_helper.dart';
import 'package:bread_app/utils/text_field_helper.dart';
import 'package:bread_app/widgets/custom/scaffold.dart';
import 'package:bread_app/widgets/custom/sized_box.dart';
import 'package:bread_app/widgets/custom/title.dart';
import 'package:bread_app/models/record.dart';
import 'package:bread_app/widgets/record/record_delete_dialog.dart';
import 'package:bread_app/widgets/record/record_edit_image.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img_pkg;

class RecordEditScreen extends StatefulWidget {
  final Record record;
  const RecordEditScreen({Key? key, required this.record}) : super(key: key);

  @override
  State<RecordEditScreen> createState() => _RecordEditScreenState();
}

class _RecordEditScreenState extends State<RecordEditScreen> {
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  RecordImages? originalImages;
  RecordImages? newImages;
  List<CustomImage> toBeAddedImages = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.record.notes.notes;
    _titleController.text = widget.record.title.title;

    originalImages = widget.record.images;
    newImages = originalImages;
  }

  @override
  Widget build(BuildContext context) {
    TextController.setController(_notesController, _notesController.text);
    TextController.setController(_titleController, _titleController.text);

    Future<void> onSave() async {
      await DbHelper().updateRecord(
        widget.record.recordId!.id,
        _titleController.text,
        _notesController.text,
        originalImages,
        newImages,
        widget.record.createdAt,
      ); //TODO: update images
      debugPrint('one record edited');

      var updatedRecord =
          await DbHelper().getRecordById(widget.record.recordId!);
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecordScreen(
            record: updatedRecord,
          ),
        ),
      );
    }

    void onDelete(String imagePath) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => DeleteDialog(
                onConfirm: () {
                  setState(() {
                    newImages!.imagePaths.remove(imagePath);
                  });
                  Navigator.pop(context);
                },
                text: 'Are you sure you want to delete this image?',
              ));
    }

    void onDeleteToBeAdded(CustomImage img) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => DeleteDialog(
                onConfirm: () {
                  setState(() {
                    toBeAddedImages.remove(img);
                  });
                  Navigator.pop(context);
                },
                text: 'Are you sure you want to delete this image?',
              ));
    }

    Future<void> pickAndCropImage() async {
      var pickedFiles = await ImageHelper().pickMultiImage();

      if (pickedFiles != null) {
        for (var file in pickedFiles) {
          var croppedImage = await ImageHelper().cropImage(file, false);
          setState(() {
            toBeAddedImages
                .add(CustomImage(pickedImage: file, image: croppedImage));
          });
        }
      }
    }

    List<Widget> imageWidgets = List.empty(growable: true);
    void setImageWidgets() {
      if (newImages != null) {
        for (var path in newImages!.imagePaths) {
          imageWidgets.add(EditImage(
              imageWidget: Image.file(
                File(path),
                height: 150,
              ),
              onDelete: () {
                onDelete(path);
              }));
        }
      }
      if (toBeAddedImages.isNotEmpty) {
        for (var img in toBeAddedImages) {
          imageWidgets.add(EditImage(
            imageWidget: Image.memory(
              Uint8List.fromList(img_pkg.encodePng(img.image!)),
              height: 150,
            ),
            onDelete: () {
              onDeleteToBeAdded(img);
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
            text: "Edit Record",
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
            onChanged: (value) {
              _titleController.text = value;
            },
          ),
          const CustomSizedBox(),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(labelText: "Notes"),
            maxLines: 10,
            onChanged: (value) {
              _notesController.text = value;
            },
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
