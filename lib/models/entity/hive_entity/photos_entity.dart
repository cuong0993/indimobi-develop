import 'package:hive/hive.dart';

part 'photos_entity.g.dart';

@HiveType(typeId: 3)
class PhotosEntity {
  @HiveField(0)
  List<int>? size;
  @HiveField(1)
  String? path;

  @HiveField(2)
  List<int>? loc;
  @HiveField(3)
  List<int>? imageCrop;
  @HiveField(4)
  int? indexL;
  @HiveField(5)
  String? idLocal;

  PhotosEntity({
    this.size,
    this.indexL,
    this.path,
    this.loc,
    this.imageCrop,
    this.idLocal,
  });

  PhotosEntity copyWith({
    List<int>? size,
    String? path,
    List<int>? listUnitLocal,
    List<int>? loc,
    List<int>? imageCrop,
    int? indexL,
    String? idLocal,
  }) {
    return PhotosEntity(
      size: size ?? this.size,
      path: path ?? this.path,
      loc: loc ?? this.loc,
      imageCrop: imageCrop ?? this.imageCrop,
      indexL: indexL ?? this.indexL,
      idLocal: idLocal ?? this.idLocal,
    );
  }

  PhotosEntity.fromJson(dynamic json) {
    size = json['size'] != null ? json['size'].cast<int>() : [];
    path = json['path'];
    indexL = json['indexL'];
    idLocal = json['idLocal'];
    loc = json['loc'] != null ? json['loc'].cast<int>() : [];
    imageCrop = json['imageCrop'] != null ? json['imageCrop'].cast<int>() : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['size'] = size;
    map['indexL'] = indexL;
    map['path'] = path;
    map['loc'] = loc;
    map['imageCrop'] = imageCrop;
    map['idLocal'] = idLocal;
    return map;
  }
}
