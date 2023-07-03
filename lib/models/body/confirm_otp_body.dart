class ConfirmOtpBody {
  ConfirmOtpBody({
    this.phone,
    this.otp,
  });

  ConfirmOtpBody.fromJson(dynamic json) {
    phone = json['phone'];
    otp = json['otp'];
  }

  String? phone;
  String? otp;

  ConfirmOtpBody copyWith({
    String? phone,
    String? otp,
  }) =>
      ConfirmOtpBody(
        phone: phone ?? this.phone,
        otp: otp ?? this.otp,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = phone;
    map['otp'] = otp;
    return map;
  }
}
