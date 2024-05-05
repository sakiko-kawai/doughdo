class Record {
  final RecordId? recordId;
  final Notes notes;
  final CreatedAt createdAt;
  final UpdatedAt updatedAt;

  const Record({
    this.recordId,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'notes': notes.notes,
      'created_at': createdAt.createdAt.toIso8601String(),
      'updated_at': updatedAt.updatedAt.toIso8601String(),
    };

    if (recordId != null) map['id'] = recordId?.id.toString();

    return map;
  }

  static Record fromMap(Map<String, dynamic> map) {
    return Record(
      recordId: RecordId(id: map['id']),
      notes: Notes(notes: map['notes']),
      createdAt: CreatedAt(DateTime.parse(map['created_at'])),
      updatedAt: UpdatedAt(DateTime.parse(map['updated_at'])),
    );
  }
}

class RecordId {
  final int id;
  const RecordId({required this.id});
}

class Notes {
  final String notes;
  const Notes({required this.notes});
}

class CreatedAt {
  final DateTime createdAt;
  const CreatedAt(this.createdAt);
}

class UpdatedAt {
  final DateTime updatedAt;
  const UpdatedAt(this.updatedAt);
}
