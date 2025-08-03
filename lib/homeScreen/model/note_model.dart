class NoteModel {
  final int noteId;
  final String title;
  final String content;
  final int usersId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NoteModel({
    required this.noteId,
    required this.title,
    required this.content,
    required this.usersId,
    required this.createdAt,
    this.updatedAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      noteId: json['note_id'],
      title: json['title'],
      content: json['content'],
      usersId: json['users_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'note_id': noteId,
      'title': title,
      'content': content,
      'users_id': usersId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
