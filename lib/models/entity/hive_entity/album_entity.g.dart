// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumEntityAdapter extends TypeAdapter<AlbumEntity> {
  @override
  final int typeId = 1;

  @override
  AlbumEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlbumEntity(
      id: fields[0] as String?,
      type: fields[1] as String?,
      size: fields[2] as SizeEntity?,
      pages: (fields[3] as List?)?.cast<PagesEntity>(),
      cover: fields[4] as PagesEntity?,
      name: fields[5] as String?,
      typeName: fields[6] as String?,
      price: fields[7] as String?,
      product_id: fields[8] as String?,
      isAndroid: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AlbumEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.size)
      ..writeByte(3)
      ..write(obj.pages)
      ..writeByte(4)
      ..write(obj.cover)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.typeName)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.product_id)
      ..writeByte(9)
      ..write(obj.isAndroid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
