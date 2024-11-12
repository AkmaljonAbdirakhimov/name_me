import 'package:equatable/equatable.dart';

class NamePreference extends Equatable {
  final String gender;
  final String origin;
  final List<String> qualities;
  final List<String> style;
  final String country;
  final String? additionalNotes;
  final String fatherName;
  final String motherName;
  final List<String> excludeNames;

  const NamePreference({
    required this.gender,
    required this.origin,
    required this.qualities,
    required this.style,
    required this.country,
    this.additionalNotes,
    required this.fatherName,
    required this.motherName,
    required this.excludeNames,
  });

  NamePreference copyWith({
    String? gender,
    String? origin,
    List<String>? qualities,
    List<String>? style,
    String? country,
    String? additionalNotes,
    String? fatherName,
    String? motherName,
    List<String>? excludeNames,
  }) {
    return NamePreference(
      gender: gender ?? this.gender,
      origin: origin ?? this.origin,
      qualities: qualities ?? this.qualities,
      style: style ?? this.style,
      country: country ?? this.country,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      excludeNames: excludeNames ?? this.excludeNames,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'gender': gender});
    result.addAll({'origin': origin});
    result.addAll({'qualities': qualities});
    result.addAll({'style': style});
    result.addAll({'country': country});
    if (additionalNotes != null) {
      result.addAll({'additionalNotes': additionalNotes});
    }
    result.addAll({'fatherName': fatherName});
    result.addAll({'motherName': motherName});
    result.addAll({'excludeNames': excludeNames});

    return result;
  }

  factory NamePreference.fromMap(Map<String, dynamic> map) {
    return NamePreference(
      gender: map['gender'] ?? '',
      origin: map['origin'] ?? '',
      qualities: List<String>.from(map['qualities']),
      style: List<String>.from(map['style']),
      country: map['country'] ?? '',
      additionalNotes: map['additionalNotes'],
      fatherName: map['fatherName'] ?? '',
      motherName: map['motherName'] ?? '',
      excludeNames: map['excludeNames'] != null
          ? List<String>.from(map['excludeNames'])
          : [],
    );
  }

  factory NamePreference.initial() {
    return const NamePreference(
      country: '',
      gender: '',
      origin: '',
      qualities: [],
      style: [],
      additionalNotes: null,
      fatherName: '',
      motherName: '',
      excludeNames: [],
    );
  }

  @override
  List<Object?> get props {
    return [
      gender,
      origin,
      qualities,
      style,
      country,
      additionalNotes,
      fatherName,
      motherName,
      excludeNames,
    ];
  }
}
