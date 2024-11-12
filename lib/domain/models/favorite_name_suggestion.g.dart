// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_name_suggestion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteNameSuggestionAdapter
    extends TypeAdapter<FavoriteNameSuggestion> {
  @override
  final int typeId = 1;

  @override
  FavoriteNameSuggestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteNameSuggestion(
      name: (fields[0] as Map).cast<String, String>(),
      meaning: (fields[1] as Map).cast<String, String>(),
      origin: (fields[2] as Map).cast<String, String>(),
      culturalContext: (fields[3] as Map).cast<String, String>(),
      familyConnection: (fields[4] as Map).cast<String, String>(),
      gender: fields[5] as Genders,
      popularityScore: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteNameSuggestion obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.meaning)
      ..writeByte(2)
      ..write(obj.origin)
      ..writeByte(3)
      ..write(obj.culturalContext)
      ..writeByte(4)
      ..write(obj.familyConnection)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.popularityScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteNameSuggestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
