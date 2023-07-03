import 'package:hive/hive.dart';
import 'package:indimobi/models/entity/hive_entity/photos_entity.dart';
import 'package:indimobi/models/entity/hive_entity/stickers_entity.dart';
import 'package:indimobi/models/entity/hive_entity/texts_entity.dart';

part 'pages_entity.g.dart';

@HiveType(typeId: 2)
class PagesEntity {
  @HiveField(0)
  String? idLocal;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? layout;
  @HiveField(3)
  List<PhotosEntity>? photos;
  @HiveField(4)
  List<TextsEntity>? texts;
  @HiveField(5)
  List<StickersEntity>? stickers;
  @HiveField(6)
  bool? isEditCover;

  PagesEntity({
    this.idLocal,
    this.name,
    this.layout,
    this.photos,
    this.texts,
    this.stickers,
    this.isEditCover,
  });

  PagesEntity copyWith({
    String? idLocal,
    String? name,
    String? layout,
    List<PhotosEntity>? photos,
    List<TextsEntity>? texts,
    List<StickersEntity>? stickers,
    bool? isEditCover,
  }) {
    return PagesEntity(
      idLocal: idLocal ?? this.idLocal,
      name: name ?? this.name,
      layout: layout ?? this.layout,
      photos: photos ?? this.photos,
      texts: texts ?? this.texts,
      stickers: stickers ?? this.stickers,
      isEditCover: isEditCover ?? this.isEditCover,
    );
  }

  PagesEntity.fromJson(dynamic json) {
    idLocal = json['idLocal'];
    name = json['name'];
    layout = json['layout'];
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos?.add(PhotosEntity.fromJson(v));
      });
    }
    if (json['texts'] != null) {
      texts = [];
      json['texts'].forEach((v) {
        texts?.add(TextsEntity.fromJson(v));
      });
    }
    if (json['stickers'] != null) {
      stickers = [];
      json['stickers'].forEach((v) {
        stickers?.add(StickersEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idLocal'] = idLocal;
    map['name'] = name;
    map['layout'] = layout;
    if (photos != null) {
      map['photos'] = photos?.map((v) => v.toJson()).toList();
    }
    if (texts != null) {
      map['texts'] = texts?.map((v) => v.toJson()).toList();
    }
    if (stickers != null) {
      map['stickers'] = stickers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
