class UserModel {
  final int id;
  final String username;
  final String email;
  final DateTime created;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.created,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      created: DateTime.parse(json['created']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'created': created.toIso8601String(),
    };
  }
}
