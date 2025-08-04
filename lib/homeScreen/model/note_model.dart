class NoteModel {
  int? noteId;
  String? title;
  String? content; 
  int? usersId;
  DateTime? createdAt;

  NoteModel({
    this.noteId,
    this.title,
    this.content,
    this.usersId,
    this.createdAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      noteId: json['note_id'],
      title: json['title'],
      content: json['message'],
      usersId: json['users_id'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'note_id': noteId,
      'title': title,
      'message': content,
      'users_id': usersId,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
