class UserData {
  int? usersId;
  String? username;
  String? email;
  String? password;
  String? createdAt;

  UserData({
    this.usersId,
    this.username,
    this.email,
    this.password,
    this.createdAt,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_id'] = this.usersId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    return data;
  }
}
