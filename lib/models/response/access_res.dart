class AccessRes {
  AccessRes({
    this.access,
  });

  AccessRes.fromJson(dynamic json) {
    access = json['access'];
  }

  String? access;

  AccessRes copyWith({
    String? access,
  }) =>
      AccessRes(
        access: access ?? this.access,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access'] = access;
    return map;
  }
}
