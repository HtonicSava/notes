// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteHiveAdapter extends TypeAdapter<NoteHive> {
  @override
  final int typeId = 0;

  @override
  NoteHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteHive(
      description: fields[1] as String,
      title: fields[0] as String,
      imagePath: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NoteHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
