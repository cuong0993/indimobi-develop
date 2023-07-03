// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photos_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotosEntityAdapter extends TypeAdapter<PhotosEntity> {
  @override
  final int typeId = 3;

  @override
  PhotosEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotosEntity(
      size: (fields[0] as List?)?.cast<int>(),
      indexL: fields[4] as int?,
      path: fields[1] as String?,
      loc: (fields[2] as List?)?.cast<int>(),
      imageCrop: (fields[3] as List?)?.cast<int>(),
      idLocal: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PhotosEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.size)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.loc)
      ..writeByte(3)
      ..write(obj.imageCrop)
      ..writeByte(4)
      ..write(obj.indexL)
      ..writeByte(5)
      ..write(obj.idLocal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotosEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
