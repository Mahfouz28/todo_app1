class NoteAddModel {
  final String? status;
  final String? message;

  NoteAddModel({this.status, this.message});

  // Factory constructor to deserialize from JSON
  factory NoteAddModel.fromJson(Map<String, dynamic> json) {
    return NoteAddModel(status: json['status'], message: json['message']);
  }

  // Convert model to JSON map
  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message};
  }
}
