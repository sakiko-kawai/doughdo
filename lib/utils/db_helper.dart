import 'package:bread_app/models/record.dart';
import 'package:bread_app/utils/image_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbHelper {
  String tableName = "record";
  final supabase = Supabase.instance.client;

  Future<void> insertRecord(
    String title,
    String notes,
    List<XFile>? images,
    XFile? thumbnailImage,
  ) async {
    Record record = Record(
      title: RecordTitle(title: title),
      notes: Notes(notes: notes),
      createdAt: CreatedAt(DateTime.now().toIso8601String()),
      updatedAt: UpdatedAt(DateTime.now().toIso8601String()),
    );
    if (images != null) {
      List<String>? imagePaths = await ImageHelper().saveImages(images);
      record.images = RecordImages(imagePaths: imagePaths);
      record.thumbnail = RecordThumbnailImage(imagePath: imagePaths[0]);
    }

    await supabase.from(tableName).insert(record.toMap());
  }

  Future<void> updateRecord(
    int recordId,
    String title,
    String notes,
    RecordImages? originalImages,
    RecordImages? newImages,
    List<XFile>? toBeAddedImages,
    CreatedAt createdAt,
  ) async {
    Record record = Record(
      title: RecordTitle(title: title),
      notes: Notes(notes: notes),
      createdAt: createdAt,
      updatedAt: UpdatedAt(DateTime.now().toIso8601String()),
    );

    RecordImages? updatedImgs =
        await getUpdatedImages(originalImages, newImages, toBeAddedImages);
    record.images = updatedImgs;

    await supabase.from(tableName).update(record.toMap()).eq('id', recordId);
  }

  Future<RecordImages?> getUpdatedImages(
    RecordImages? originalImages,
    RecordImages? newImages,
    List<XFile>? toBeAddedImages,
  ) async {
    RecordImages? toBeDeleted;
    if (originalImages != null) {
      if (newImages == null) {
        toBeDeleted = originalImages;
      } else {
        Set<String> orgImgs = originalImages.imagePaths.toSet();
        Set<String> newImgs = newImages.imagePaths.toSet();
        List<String> difference = orgImgs.difference(newImgs).toList();
        toBeDeleted = RecordImages(imagePaths: difference);
      }
    }

    if (toBeDeleted != null) {
      await ImageHelper().deleteImages(toBeDeleted);
    }

    //TODO: change the thumbnail

    RecordImages? toBeAdded;
    if (toBeAddedImages != null) {
      debugPrint("is good");
      List<String>? imagePaths =
          await ImageHelper().saveImages(toBeAddedImages);
      toBeAdded = RecordImages(imagePaths: imagePaths);
    }

    RecordImages? updatedImages;
    if (newImages != null) {
      if (toBeAdded != null) {
        debugPrint("add lists");
        updatedImages = RecordImages(
            imagePaths: newImages.imagePaths + toBeAdded.imagePaths);
      } else {
        updatedImages = RecordImages(imagePaths: newImages.imagePaths);
      }
    } else {
      if (toBeAdded != null) {
        updatedImages = RecordImages(imagePaths: toBeAdded.imagePaths);
      } else {
        updatedImages = null;
      }
    }
    debugPrint(updatedImages!.imagePaths.length.toString());
    return updatedImages;
  }

  Future<List<Record>> getAllRecords() async {
    var maps = await supabase.from(tableName).select("*");
    List<Record> records = maps.map((r) => Record.fromMap(r)).toList();
    return records;
  }

  Future<Record> getRecordById(RecordId recordId) async {
    String id = recordId.id.toString();
    List<Map<String, dynamic>> maps =
        await supabase.from(tableName).select("*").eq("id", id);
    if (maps.length > 1) {
      debugPrint('There are more than one record that matches the RecordId.');
    } else if (maps.isEmpty) {
      debugPrint('There are no record that matches the RecordId.');
    }
    return Record.fromMap(maps.first);
  }

  Future<void> deleteRecord(int recordId) async {
    await ImageHelper().deleteImageOnRecord(recordId);

    await supabase.from(tableName).delete().eq("id", recordId);
  }
}
