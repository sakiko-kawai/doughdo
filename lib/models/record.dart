import 'dart:convert';

class Record {
  final RecordId? recordId;
  final RecordTitle title;
  final Notes notes;
  RecordImages? images;
  RecordThumbnailImage? thumbnail;
  final CreatedAt createdAt;
  final UpdatedAt updatedAt;

  Record({
    this.recordId,
    required this.title,
    required this.notes,
    this.images,
    this.thumbnail,
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
    if (images != null) map['images'] = jsonEncode(images?.imagePaths);
    if (thumbnail != null) map['thumbnail'] = thumbnail?.imagePath;

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

    if (map['images'] != null) {
      record.images = RecordImages(
          imagePaths: List<String>.from(jsonDecode(map['images'])));
    }

    if (map['thumbnail'] != null) {
      record.thumbnail = RecordThumbnailImage(imagePath: map['thumbnail']);
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

class RecordImages {
  final List<String> imagePaths;
  const RecordImages({required this.imagePaths});
}

class RecordThumbnailImage {
  final String imagePath;
  const RecordThumbnailImage({required this.imagePath});
}

class CreatedAt {
  final String createdAt;
  const CreatedAt(this.createdAt);
}

class UpdatedAt {
  final String updatedAt;
  const UpdatedAt(this.updatedAt);
}
