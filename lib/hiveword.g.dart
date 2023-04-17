// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveword.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class hivewordAdapter extends TypeAdapter<hiveword> {
  @override
  final int typeId = 0;

  @override
  hiveword read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return hiveword(
      word: fields[1] as String,
      date: fields[0] as String,
      learn: fields[2] as bool,
      turkish: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, hiveword obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.word)
      ..writeByte(2)
      ..write(obj.learn)
      ..writeByte(3)
      ..write(obj.turkish);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is hivewordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
