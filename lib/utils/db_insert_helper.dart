import 'package:bread_app/models/record.dart';
import 'package:bread_app/utils/db_helper.dart';

class DbInsertHelper {
  Future<void> insertRecord(
    String notes,
    String createdAt,
    String updatedAt,
  ) async {
    var db = await DbHelper().database;
    await db.insert(
      'record',
      Record(
        notes: Notes(notes: notes),
        createdAt: CreatedAt(DateTime.parse(createdAt)),
        updatedAt: UpdatedAt(DateTime.parse(updatedAt)),
      ).toMap(),
    );
  }
}
