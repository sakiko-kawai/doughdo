import 'dart:io';

import 'package:bread_app/models/record.dart';
import 'package:bread_app/utils/db_helper.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:image/image.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelper {
  Future<String> saveImage(XFile image) async {
    return await cropAndSaveImage(image, false);
  }

  Future<String> createThumbnail(XFile image) async {
   return await cropAndSaveImage(image, true);
  }

  Future<String> cropAndSaveImage(XFile image, bool isThumbnail) async {
    Image? decodedImage = await decodeImageFile(image.path);
    final dir = await getApplicationSupportDirectory();
    final imageName = isThumbnail ? "thumbnail_${image.name}" : image.name;
    final savedImagePath = await getUniqueFilePath(dir.path, imageName);

    if (decodedImage != null) {
      final size = isThumbnail ? 100 : 400;
      Image thumbnail = copyResizeCropSquare(decodedImage, size: size);
      encodeImageFile(savedImagePath, thumbnail);
    }

    return savedImagePath;
  }

  Future<String> getUniqueFilePath(String directory, String filename) async {
    String filePath = path.join(directory, filename);
    String fileNameWithoutExtension = path.basenameWithoutExtension(filePath);
    String fileExtension = path.extension(filePath);
    int counter = 1;

    while (File(filePath).existsSync()) {
      filePath = path.join(
          directory, '$fileNameWithoutExtension($counter)$fileExtension');
      counter++;
    }

    return filePath;
  }

  Future<void> deleteImage(int recordId) async {
    var record = await DbHelper().getRecordById(RecordId(id: recordId));
    if (record.thumbnail?.imagePath != null) {
      try {
        await File(record.thumbnail!.imagePath).delete();
      } on PathNotFoundException catch (_) {
        debugPrint("Failed to delete image.");
      }
    }

    if (record.image?.imagePath != null) {
      try {
        await File(record.image!.imagePath).delete();
      } on PathNotFoundException catch (_) {
        debugPrint("Failed to delete image.");
      }
    }
  }
}
