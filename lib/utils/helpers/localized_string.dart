import 'package:equatable/equatable.dart';

class LocalizedString extends Equatable {
  final Map<String, String> values;

  const LocalizedString({
    required this.values,
  });

  String get(String languageCode) => values[languageCode] ?? '';

  factory LocalizedString.fromMap(Map<String, dynamic> map) {
    return LocalizedString(
      values: Map<String, String>.from(map),
    );
  }

  @override
  List<Object> get props => [values];
}
