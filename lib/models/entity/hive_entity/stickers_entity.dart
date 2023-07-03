import 'package:hive/hive.dart';

part 'stickers_entity.g.dart';

@HiveType(typeId: 5)
class StickersEntity {
  @HiveField(0)
  String? idLocal;
  @HiveField(1)
  double? centerX;
  @HiveField(2)
  double? angle;
  @HiveField(3)
  double? centerY;
  @HiveField(4)
  String? image;
  @HiveField(5)
  String? pathAssets;
  @HiveField(6)
  double? width;
  @HiveField(7)
  double? height;
  @HiveField(8)
  bool? isFlip;

  StickersEntity({
    this.idLocal,
    this.centerX,
    this.angle,
    this.centerY,
    this.image,
    this.pathAssets,
    this.width,
    this.height,
    this.isFlip,
  });

  StickersEntity copyWith({
    String? idLocal,
    double? centerX,
    double? angle,
    double? centerY,
    String? image,
    String? pathAssets,
    double? width,
    double? height,
    bool? isFlip,
  }) {
    return StickersEntity(
      centerX: centerX ?? this.centerX,
      angle: angle ?? this.angle,
      centerY: centerY ?? this.centerY,
      image: image ?? this.image,
      pathAssets: pathAssets ?? this.pathAssets,
      width: width ?? this.width,
      height: height ?? this.height,
      idLocal: idLocal ?? this.idLocal,
      isFlip: isFlip ?? this.isFlip,
    );
  }

  StickersEntity.fromJson(dynamic json) {
    idLocal = json['idByDate'];
    centerX = json['centerX'];
    angle = json['angle'];
    centerY = json['centerY'];
    image = json['image'];
    pathAssets = json['pathLocal'];
    width = json['width'];
    height = json['height'];
    isFlip = json['isFlip'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idByDate'] = idLocal;
    map['centerX'] = centerX;
    map['angle'] = angle;
    map['centerY'] = centerY;
    map['image'] = image;
    map['pathLocal'] = pathAssets;
    map['width'] = width;
    map['height'] = height;
    map['isFlip'] = isFlip;
    return map;
  }
}
