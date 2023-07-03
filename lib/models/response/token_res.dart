class TokenRes {
  TokenRes({
    this.refresh,
    this.access,
  });

  TokenRes.fromJson(dynamic json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  String? refresh;
  String? access;

  TokenRes copyWith({
    String? refresh,
    String? access,
  }) =>
      TokenRes(
        refresh: refresh ?? this.refresh,
        access: access ?? this.access,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh'] = refresh;
    map['access'] = access;
    return map;
  }
}
