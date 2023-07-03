import 'package:hive/hive.dart';

part 'size_entity.g.dart';

@HiveType(typeId: 4)
class SizeEntity {
  @HiveField(0)
  int? width;
  @HiveField(1)
  int? height;

  SizeEntity({
    this.width,
    this.height,
  });

  SizeEntity.fromJson(dynamic json) {
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['width'] = width;
    map['height'] = height;
    return map;
  }
}
