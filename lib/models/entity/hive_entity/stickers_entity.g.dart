// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stickers_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StickersEntityAdapter extends TypeAdapter<StickersEntity> {
  @override
  final int typeId = 5;

  @override
  StickersEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StickersEntity(
      idLocal: fields[0] as String?,
      centerX: fields[1] as double?,
      angle: fields[2] as double?,
      centerY: fields[3] as double?,
      image: fields[4] as String?,
      pathAssets: fields[5] as String?,
      width: fields[6] as double?,
      height: fields[7] as double?,
      isFlip: fields[8] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, StickersEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.idLocal)
      ..writeByte(1)
      ..write(obj.centerX)
      ..writeByte(2)
      ..write(obj.angle)
      ..writeByte(3)
      ..write(obj.centerY)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.pathAssets)
      ..writeByte(6)
      ..write(obj.width)
      ..writeByte(7)
      ..write(obj.height)
      ..writeByte(8)
      ..write(obj.isFlip);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StickersEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
