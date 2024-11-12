import 'package:equatable/equatable.dart';

import '../../utils/utils.dart';
import 'gender.dart';

class NameSuggestion extends Equatable {
  final LocalizedString name;
  final LocalizedString meaning;
  final LocalizedString origin;
  final LocalizedString culturalContext;
  final LocalizedString familyConnection;
  final Genders gender;
  final int? popularityScore;
  final bool isFavorite;
  const NameSuggestion({
    required this.name,
    required this.meaning,
    required this.origin,
    required this.culturalContext,
    required this.familyConnection,
    required this.gender,
    this.popularityScore,
    this.isFavorite = false,
  });

  NameSuggestion copyWith({
    LocalizedString? name,
    LocalizedString? meaning,
    LocalizedString? origin,
    LocalizedString? culturalContext,
    LocalizedString? familyConnection,
    Genders? gender,
    int? popularityScore,
    bool? isFavorite,
  }) {
    return NameSuggestion(
      name: name ?? this.name,
      meaning: meaning ?? this.meaning,
      origin: origin ?? this.origin,
      culturalContext: culturalContext ?? this.culturalContext,
      familyConnection: familyConnection ?? this.familyConnection,
      gender: gender ?? this.gender,
      popularityScore: popularityScore ?? this.popularityScore,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory NameSuggestion.fromMap(Map<String, dynamic> map) {
    return NameSuggestion(
      name: LocalizedString.fromMap(map['name']),
      meaning: LocalizedString.fromMap(map['meaning']),
      origin: LocalizedString.fromMap(map['origin']),
      culturalContext: LocalizedString.fromMap(map['culturalContext']),
      familyConnection: LocalizedString.fromMap(map['familyConnection']),
      gender: Genders.values.firstWhere((g) => g.name == map['gender']),
      popularityScore: map['popularityScore']?.toInt(),
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      meaning,
      origin,
      culturalContext,
      familyConnection,
      gender,
      popularityScore,
    ];
  }
}
