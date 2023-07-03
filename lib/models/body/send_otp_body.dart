class SendOtpBody {
  SendOtpBody({
    this.phone,
    this.deviceId,
  });

  SendOtpBody.fromJson(dynamic json) {
    phone = json['phone'];
    deviceId = json['device_id'];
  }

  String? phone;
  String? deviceId;

  SendOtpBody copyWith({
    String? phone,
    String? deviceId,
  }) =>
      SendOtpBody(
        phone: phone ?? this.phone,
        deviceId: deviceId ?? this.deviceId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = phone;
    map['device_id'] = deviceId;
    return map;
  }
}
