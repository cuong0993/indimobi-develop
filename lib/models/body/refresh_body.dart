class RefreshBody {
  RefreshBody({
    this.refresh,
  });

  RefreshBody.fromJson(dynamic json) {
    refresh = json['refresh'];
  }

  String? refresh;

  RefreshBody copyWith({
    String? refresh,
  }) =>
      RefreshBody(
        refresh: refresh ?? this.refresh,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh'] = refresh;
    return map;
  }
}
