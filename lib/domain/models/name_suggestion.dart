import 'package:equatable/equatable.dart';

import '../../utils/utils.dart';

class NameSuggestion extends Equatable {
  final LocalizedString name;
  final LocalizedString meaning;
  final LocalizedString origin;
  final LocalizedString culturalContext;
  final LocalizedString familyConnection;
  final int? popularityScore;
  final bool isFavorite;
  const NameSuggestion({
    required this.name,
    required this.meaning,
    required this.origin,
    required this.culturalContext,
    required this.familyConnection,
    this.popularityScore,
    this.isFavorite = false,
  });

  NameSuggestion copyWith({
    LocalizedString? name,
    LocalizedString? meaning,
    LocalizedString? origin,
    LocalizedString? culturalContext,
    LocalizedString? familyConnection,
    int? popularityScore,
    bool? isFavorite,
  }) {
    return NameSuggestion(
      name: name ?? this.name,
      meaning: meaning ?? this.meaning,
      origin: origin ?? this.origin,
      culturalContext: culturalContext ?? this.culturalContext,
      familyConnection: familyConnection ?? this.familyConnection,
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
      popularityScore,
    ];
  }
}
