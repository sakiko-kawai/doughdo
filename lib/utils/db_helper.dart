import 'package:bread_app/models/record.dart';
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
  ) async {
    var db = await database;
    await db.insert(
      tableName,
      Record(
        title: RecordTitle(title: title),
        notes: Notes(notes: notes),
        createdAt: CreatedAt(DateTime.now().toIso8601String()),
        updatedAt: UpdatedAt(DateTime.now().toIso8601String()),
      ).toMap(),
    );
  }

  Future<void> updateRecord(
    int recordId,
    String title,
    String notes,
    CreatedAt createdAt,
  ) async {
    var db = await database;
    await db.update(
      tableName,
      Record(
        title: RecordTitle(title: title),
        notes: Notes(notes: notes),
        createdAt: createdAt,
        updatedAt: UpdatedAt(DateTime.now().toIso8601String()),
      ).toMap(),
      where: 'id = \'$recordId\'',
    );
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

  Future<Database> initializeDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    debugPrint(await getDatabasesPath());
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
