class UsernameBody {
  UsernameBody({
    this.username,
    this.password,
  });

  UsernameBody.fromJson(dynamic json) {
    username = json['username'];
    password = json['password'];
  }

  String? username;
  String? password;

  UsernameBody copyWith({
    String? username,
    String? password,
  }) =>
      UsernameBody(
        username: username ?? this.username,
        password: password ?? this.password,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    return map;
  }
}
