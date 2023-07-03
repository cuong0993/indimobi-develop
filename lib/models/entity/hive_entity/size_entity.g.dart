// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SizeEntityAdapter extends TypeAdapter<SizeEntity> {
  @override
  final int typeId = 4;

  @override
  SizeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SizeEntity(
      width: fields[0] as int?,
      height: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SizeEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.width)
      ..writeByte(1)
      ..write(obj.height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SizeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
