import 'dart:io';

import 'package:bread_app/models/image.dart';
import 'package:bread_app/models/record.dart';
import 'package:bread_app/utils/db_helper.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:image/image.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelper {
  static double imageSize = 250;
  static double thumbnailSize = 100;

  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>?> pickMultiImage() async {
    final pickedFiles = await _picker.pickMultiImage();
    return pickedFiles;
  }

  Future<List<String>> saveImages(List<CustomImage> images) async {
    List<String> paths = [];
    for (var image in images) {
      var path = await cropAndSaveImage(image.pickedImage!, false);
      paths.add(path);
    }
    return paths;
  }

  Future<String> createThumbnail(CustomImage image) async {
    return await cropAndSaveImage(image.pickedImage!, true);
  }

  Future<String> cropAndSaveImage(XFile image, bool isThumbnail) async {
    final dir = await getApplicationSupportDirectory();
    final imageName = isThumbnail ? "thumbnail_${image.name}" : image.name;
    final savedImagePath = await getUniqueFilePath(dir.path, imageName);

    Image croppedImage = await cropImage(image, isThumbnail);
    encodeImageFile(savedImagePath, croppedImage);

    return savedImagePath;
  }

  Future<Image> cropImage(XFile image, bool isThumbnail) async {
    Image? decodedImage = await decodeImageFile(image.path);
    Image croppedImage = Image.empty();
    if (decodedImage != null) {
      final size = isThumbnail ? thumbnailSize.toInt() : imageSize.toInt();
      croppedImage = copyResizeCropSquare(decodedImage, size: size);
    }

    return croppedImage;
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

  Future<void> deleteImageOnRecord(int recordId) async {
    var record = await DbHelper().getRecordById(RecordId(id: recordId));
    if (record.thumbnail?.imagePath != null) {
      try {
        await File(record.thumbnail!.imagePath).delete();
      } on PathNotFoundException catch (_) {
        debugPrint("Failed to delete image.");
      }
    }

    if (record.images?.imagePaths != null) {
      try {
        for (var image in record.images!.imagePaths) {
          await File(image).delete();
        }
      } on PathNotFoundException catch (_) {
        debugPrint("Failed to delete image.");
      }
    }
  }

  Future<void> deleteImages(RecordImages recordImgs) async {
    try {
      for (var image in recordImgs.imagePaths) {
        await File(image).delete();
      }
    } on PathNotFoundException catch (_) {
      debugPrint("Failed to delete image.");
    }
  }
}
