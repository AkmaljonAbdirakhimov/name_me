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

  const NamePreference({
    required this.gender,
    required this.origin,
    required this.qualities,
    required this.style,
    required this.country,
    this.additionalNotes,
    required this.fatherName,
    required this.motherName,
  });

  NamePreference copyWith({
    String? country,
    String? gender,
    String? origin,
    List<String>? qualities,
    List<String>? style,
    String? additionalNotes,
    String? fatherName,
    String? motherName,
  }) {
    return NamePreference(
      country: country ?? this.country,
      gender: gender ?? this.gender,
      origin: origin ?? this.origin,
      qualities: qualities ?? this.qualities,
      style: style ?? this.style,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'gender': gender,
      'origin': origin,
      'qualities': qualities.join(", "),
      'style': style.join(", "),
      'additionalNotes': additionalNotes,
      'fatherName': fatherName,
      'motherName': motherName,
    };
  }

  factory NamePreference.fromMap(Map<String, dynamic> map) {
    return NamePreference(
      country: map['country'] as String,
      gender: map['gender'] as String,
      origin: map['origin'] as String,
      qualities: List<String>.from(map['qualities']),
      style: List<String>.from(map['style']),
      additionalNotes: map['additionalNotes'] as String?,
      fatherName: map['father_name'] as String,
      motherName: map['mother_name'] as String,
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
    ];
  }
}
