// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_usage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppUsageAdapter extends TypeAdapter<AppUsage> {
  @override
  final int typeId = 2;

  @override
  AppUsage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppUsage(
      count: fields[0] as int,
      date: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AppUsage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUsageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
