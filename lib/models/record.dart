import 'dart:convert';

class Record {
  final RecordId? recordId;
  final RecordTitle title;
  final Notes notes;
  RecordImages? images;
  RecordThumbnailImage? thumbnail;
  final UserId? userId;
  final CreatedAt? createdAt;
  final UpdatedAt updatedAt;

  Record({
    this.recordId,
    required this.title,
    required this.notes,
    this.images,
    this.thumbnail,
    this.userId,
    this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title.title,
      'notes': notes.notes,
      'updated_at': updatedAt.updatedAt
    };

    if (recordId != null) map['id'] = recordId?.id.toString();
    if (userId != null) map['user_id'] = userId?.id;
    if (createdAt != null) map['created_at'] = createdAt?.createdAt;
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
        userId: UserId(map["user_id"]));

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

class UserId {
  final String id;
  const UserId(this.id);
}
