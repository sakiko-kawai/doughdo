import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initializeDatabase();
    return _database!;
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
