import 'dart:io';
import 'package:bread_app/models/record.dart';
import 'package:bread_app/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageHelper {
  static double imageSize = 250;
  static double imageEditSize = 150;
  static double thumbnailSize = 100;
  String recordImagebucketName = "record-image";
  final supabase = Supabase.instance.client;

  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>?> pickMultiImage() async {
    final pickedFiles = await _picker.pickMultiImage();
    return pickedFiles;
  }

  Future<List<String>> saveImages(List<XFile> images) async {
    List<String> paths = [];
    for (var image in images) {
      String path = await supabase.storage.from(recordImagebucketName).upload(
            await getUniqueFilePath("username", image.name),
            File(image.path),
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      String cleanPath = getPathWithoutBucketName(path);
      paths.add(cleanPath);
    }
    return paths;
  }

  String getPathWithoutBucketName(String path) {
    List<String> segments = List.from(Uri.parse(path).pathSegments);
    segments.removeAt(0);
    return segments.join('/');
  }

  Future<CroppedFile?> cropImage(XFile image, BuildContext context) async {
    return await ImageCropper().cropImage(
      sourcePath: image.path,
      maxHeight: imageSize.toInt(),
      maxWidth: imageSize.toInt(),
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(context: context)
      ],
    );
  }

  Future<String> getImageUrl(String path) async {
    return await supabase.storage
        .from(recordImagebucketName)
        .createSignedUrl(path, 60);
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
        await supabase.storage
            .from(recordImagebucketName)
            .remove([record.thumbnail!.imagePath]);
      } on PathNotFoundException catch (_) {
        debugPrint("Failed to delete image.");
      }
    }

    if (record.images?.imagePaths != null) {
      try {
        for (var image in record.images!.imagePaths) {
          await supabase.storage.from(recordImagebucketName).remove([image]);
        }
      } on PathNotFoundException catch (_) {
        debugPrint("Failed to delete image.");
      }
    }
  }

  Future<void> deleteImages(RecordImages recordImgs) async {
    try {
      for (var image in recordImgs.imagePaths) {
        await supabase.storage.from(recordImagebucketName).remove([image]);
      }
    } on PathNotFoundException catch (_) {
      debugPrint("Failed to delete image.");
    }
  }
}
