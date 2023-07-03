// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pages_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PagesEntityAdapter extends TypeAdapter<PagesEntity> {
  @override
  final int typeId = 2;

  @override
  PagesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PagesEntity(
      idLocal: fields[0] as String?,
      name: fields[1] as String?,
      layout: fields[2] as String?,
      photos: (fields[3] as List?)?.cast<PhotosEntity>(),
      texts: (fields[4] as List?)?.cast<TextsEntity>(),
      stickers: (fields[5] as List?)?.cast<StickersEntity>(),
      isEditCover: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PagesEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.idLocal)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.layout)
      ..writeByte(3)
      ..write(obj.photos)
      ..writeByte(4)
      ..write(obj.texts)
      ..writeByte(5)
      ..write(obj.stickers)
      ..writeByte(6)
      ..write(obj.isEditCover);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PagesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
