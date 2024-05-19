class Record {
  final RecordId? recordId;
  final RecordTitle title;
  final Notes notes;
  RecordImage? image;
  final CreatedAt createdAt;
  final UpdatedAt updatedAt;

  Record({
    this.recordId,
    required this.title,
    required this.notes,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title.title,
      'notes': notes.notes,
      'created_at': createdAt.createdAt,
      'updated_at': updatedAt.updatedAt,
    };

    if (recordId != null) map['id'] = recordId?.id.toString();
    if (image != null) map['image'] = image?.imagePath.toString();

    return map;
  }

  static Record fromMap(Map<String, dynamic> map) {
    var record = Record(
      recordId: RecordId(id: map['id']),
      title: RecordTitle(title: map['title']),
      notes: Notes(notes: map['notes']),
      createdAt: CreatedAt(map['created_at']),
      updatedAt: UpdatedAt((map['updated_at'])),
    );

    if (map['image'] != null) {
      record.image = RecordImage(imagePath: map['image']);
    }
    return record;
  }
}

class RecordId {
  final int id;
  const RecordId({required this.id});
}

class RecordTitle {
  final String title;
  const RecordTitle({required this.title});
}

class Notes {
  final String notes;
  const Notes({required this.notes});
}

class RecordImage {
  final String imagePath;
  const RecordImage({required this.imagePath});
}

class CreatedAt {
  final String createdAt;
  const CreatedAt(this.createdAt);
}

class UpdatedAt {
  final String updatedAt;
  const UpdatedAt(this.updatedAt);
}
