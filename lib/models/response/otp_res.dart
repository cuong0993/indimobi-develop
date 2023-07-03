class OtpRes {
  OtpRes({
    this.status,
    this.detail,
  });

  OtpRes.fromJson(dynamic json) {
    status = json['status'];
    detail = json['detail'];
  }

  bool? status;
  String? detail;

  OtpRes copyWith({
    bool? status,
    String? detail,
  }) =>
      OtpRes(
        status: status ?? this.status,
        detail: detail ?? this.detail,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['detail'] = detail;
    return map;
  }
}
