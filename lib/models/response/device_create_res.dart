class DeviceCreateRes {
  DeviceCreateRes({
    this.id,
    this.name,
    this.type,
    this.deviceFirebaseAddress,
    this.referralDiscount,
    this.referralBonus,
    this.money,
  });

  DeviceCreateRes.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    deviceFirebaseAddress = json['device_firebase_address'];
    referralDiscount = json['referral_discount'];
    referralBonus = json['referral_bonus'];
    money = json['money'];
  }

  String? id;
  String? name;
  int? type;
  String? deviceFirebaseAddress;
  int? referralDiscount;
  int? referralBonus;
  String? money;

  DeviceCreateRes copyWith({
    String? id,
    String? name,
    int? type,
    String? deviceFirebaseAddress,
    int? referralDiscount,
    int? referralBonus,
    String? money,
  }) =>
      DeviceCreateRes(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        deviceFirebaseAddress:
            deviceFirebaseAddress ?? this.deviceFirebaseAddress,
        referralDiscount: referralDiscount ?? this.referralDiscount,
        referralBonus: referralBonus ?? this.referralBonus,
        money: money ?? this.money,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['device_firebase_address'] = deviceFirebaseAddress;
    map['referral_discount'] = referralDiscount;
    map['referral_bonus'] = referralBonus;
    map['money'] = money;
    return map;
  }
}
