import 'package:hive/hive.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/models/entity/hive_entity/size_entity.dart';

part 'album_entity.g.dart';

@HiveType(typeId: 1)
class AlbumEntity {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? type;
  @HiveField(2)
  SizeEntity? size;
  @HiveField(3)
  List<PagesEntity>? pages;
  @HiveField(4)
  PagesEntity? cover;
  @HiveField(5)
  String? name;
  @HiveField(6)
  String? typeName;
  @HiveField(7)
  String? price;
  @HiveField(8)
  String? product_id;
  @HiveField(9)
  String? isAndroid;

  AlbumEntity({
    this.id,
    this.type,
    this.size,
    this.pages,
    this.cover,
    this.name,
    this.typeName,
    this.price,
    this.product_id,
    this.isAndroid,
  });

  AlbumEntity copyWith({
    String? id,
    String? type,
    SizeEntity? size,
    List<PagesEntity>? pages,
    PagesEntity? cover,
    String? name,
    String? typeName,
    String? price,
    String? product_id,
    String? isAndroid,
  }) {
    return AlbumEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      size: size ?? this.size,
      pages: pages ?? this.pages,
      cover: cover ?? this.cover,
      name: name ?? this.name,
      typeName: typeName ?? this.typeName,
      price: price ?? this.price,
      product_id: product_id ?? this.product_id,
      isAndroid: isAndroid ?? this.isAndroid,
    );
  }

  AlbumEntity.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    size = json['size'] != null ? SizeEntity.fromJson(json['size']) : null;
    if (json['pages'] != null) {
      pages = [];
      json['pages'].forEach((v) {
        pages?.add(PagesEntity.fromJson(v));
      });
    }
    cover = json['cover'];
    name = json['name'];
    typeName = json['typeName'];
    price = json['price'];
    product_id = json['product_id'];
    isAndroid = json['isAndroid'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    if (size != null) {
      map['size'] = size?.toJson();
    }
    if (pages != null) {
      map['pages'] = pages?.map((v) => v.toJson()).toList();
    }
    map['cover'] = cover;
    map['name'] = name;
    map['typeName'] = typeName;
    map['price'] = price;
    map['product_id'] = product_id;
    map['isAndroid'] = isAndroid;
    return map;
  }
}
