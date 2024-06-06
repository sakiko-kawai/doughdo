import 'package:bread_app/models/image.dart';
import 'package:bread_app/models/record.dart';
import 'package:bread_app/utils/image_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbHelper {
  static Database? _database;
  String tableName = "record";

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initializeDatabase();
    return _database!;
  }

  Future<void> insertRecord(
    String title,
    String notes,
    List<CustomImage>? images,
    CustomImage? thumbnailImage,
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
    }

    if (thumbnailImage != null) {
      String? thumbnailPath =
          await ImageHelper().createThumbnail(thumbnailImage);
      record.thumbnail = RecordThumbnailImage(imagePath: thumbnailPath);
    }

    var db = await database;
    await db.insert(
      tableName,
      record.toMap(),
    );
  }

  Future<void> updateRecord(
    int recordId,
    String title,
    String notes,
    RecordImages? originalImages,
    RecordImages? newImages,
    List<CustomImage>? toBeAddedImages,
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

    var db = await database;
    await db.update(
      tableName,
      record.toMap(),
      where: 'id = \'$recordId\'',
    );
  }

  Future<RecordImages?> getUpdatedImages(
    RecordImages? originalImages,
    RecordImages? newImages,
    List<CustomImage>? toBeAddedImages,
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
      List<String>? imagePaths =
          await ImageHelper().saveImages(toBeAddedImages);
      toBeAdded = RecordImages(imagePaths: imagePaths);
    }

    RecordImages? updatedImages;
    if (newImages != null) {
      if (toBeAdded != null) {
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
    return updatedImages;
  }

  Future<List<Record>> getAllRecords() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('record');
    List<Record> records =
        maps.map((record) => Record.fromMap(record)).toList();

    return records;
  }

  Future<Record> getRecordById(RecordId recordId) async {
    final db = await database;
    String id = recordId.id.toString();
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = \'$id\'',
    );
    if (maps.length > 1) {
      debugPrint('There are more than one record that matches the RecordId.');
    } else if (maps.isEmpty) {
      debugPrint('There are no record that matches the RecordId.');
    }
    return Record.fromMap(maps.first);
  }

  Future<void> deleteRecord(int recordId) async {
    await ImageHelper().deleteImageOnRecord(recordId);

    var db = await database;
    await db.delete(
      tableName,
      where: 'id = \'$recordId\'',
    );
  }

  Future<Database> initializeDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    String dbPath = join(await getDatabasesPath(), 'local.db');

    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        debugPrint("create database");

        await db.execute(
          '''
          CREATE TABLE record (
            id INTEGER PRIMARY KEY, 
            title TEXT, 
            notes TEXT, 
            images TEXT,
            thumbnail TEXT,
            created_at TEXT, 
            updated_at TEXT
            )
          ''',
        );
      },
    );

    return _database!;
  }

  Future close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
