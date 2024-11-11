import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String text;
  final String type;
  final List<String> options;
  final bool isMultipleSelect;
  const Question({
    required this.text,
    required this.type,
    required this.options,
    this.isMultipleSelect = false,
  });

  Question copyWith({
    String? text,
    String? type,
    List<String>? options,
    bool? isMultipleSelect,
  }) {
    return Question(
      text: text ?? this.text,
      type: type ?? this.type,
      options: options ?? this.options,
      isMultipleSelect: isMultipleSelect ?? this.isMultipleSelect,
    );
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      text: map['text'] ?? '',
      type: map['type'] ?? '',
      options: List<String>.from(map['options']),
      isMultipleSelect: map['isMultipleSelect'] ?? false,
    );
  }

  @override
  List<Object> get props => [text, type, options, isMultipleSelect];
}
