// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GendersAdapter extends TypeAdapter<Genders> {
  @override
  final int typeId = 0;

  @override
  Genders read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Genders.boy;
      case 1:
        return Genders.girl;
      case 2:
        return Genders.both;
      default:
        return Genders.boy;
    }
  }

  @override
  void write(BinaryWriter writer, Genders obj) {
    switch (obj) {
      case Genders.boy:
        writer.writeByte(0);
        break;
      case Genders.girl:
        writer.writeByte(1);
        break;
      case Genders.both:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GendersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
