class CreateDeviceBody {
  CreateDeviceBody({
    this.id,
    this.type,
    this.name,
  });

  CreateDeviceBody.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
  }

  String? id;
  String? type;
  String? name;

  CreateDeviceBody copyWith({
    String? id,
    String? type,
    String? name,
  }) =>
      CreateDeviceBody(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    return map;
  }
}
