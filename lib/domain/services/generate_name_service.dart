import 'dart:convert';
import 'dart:developer';

import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../domain.dart';

class GenerateNamesService {
  final GenerativeModel _generativeModel;

  GenerateNamesService(
    this._generativeModel,
  );

  Stream<NameSuggestion> streamNameSuggestions(
    NamePreference preferences,
  ) async* {
    try {
      final prompt = _buildPrompt(preferences);
      final content = [Content.text(prompt)];

      String buffer = '';
      await for (final response
          in _generativeModel.generateContentStream(content)) {
        final text = response.text ?? '';
        buffer += text;

        final startIndex = buffer.indexOf('[');
        final endIndex = buffer.lastIndexOf(']');

        try {
          if (startIndex != -1 && endIndex != -1) {
            final List<dynamic> parsed =
                json.decode(buffer.substring(startIndex, endIndex + 1));
            final suggestions =
                parsed.map((json) => NameSuggestion.fromMap(json)).toList();

            // Yield any new suggestions
            for (final suggestion in suggestions) {
              yield suggestion;
            }
            buffer = buffer.substring(endIndex + 1);
          }
        } catch (e) {
          log('Error parsing remaining buffer: $e');
          continue;
        }
      }
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());

      throw "try_later";
    }
  }

  String _buildPrompt(NamePreference preferences) {
    final qualities = preferences.qualities
        .map((q) => AppConstants.namePreferences[q])
        .toList()
        .join(", ");

    final styles = preferences.style
        .map((s) => AppConstants.namePreferences[s])
        .toList()
        .join(", ");

    return '''
You are a baby name expert specializing in names from ${preferences.country}. 
You must respond ONLY with a JSON containing 5 name suggestions.
Each response must be a valid, complete JSON array that can be parsed independently.
Do not include any explanatory text before or after the JSON.

Format each name suggestion using exactly this structure:
${_jsonTemplate()}

Consider these requirements when generating names:
- Gender: ${AppConstants.namePreferences[preferences.gender]}
- Origin: ${AppConstants.namePreferences[preferences.origin]}
- Qualities: $qualities
- Style: $styles
- Country Context: ${preferences.country}
${preferences.additionalNotes != null ? '- Additional Notes: ${preferences.additionalNotes}' : ''}

Parent Information:
- Father's Name: ${preferences.fatherName}
- Mother's Name: ${preferences.motherName}

${preferences.excludeNames.isNotEmpty ? 'Please exclude the following names: ${preferences.excludeNames.join(", ")}' : ''}

Important Constraints:
1. Each name should respect ${preferences.country}'s cultural context
2. Names should have meaningful connections to parents' names where possible
3. Consider local naming traditions
4. Popularity score must be between 0-100
5. All translations must be provided in Uzbek (uz) NOT CYRILLIC, Russian (ru), and English (en)

Remember: Give each name suggestion ONLY with the JSON array in total 5 names. No additional text.
''';
  }

  String _jsonTemplate() {
    return '''
[
  {
    "name": {
      "uz": "string",
      "ru": "string",
      "en": "string"
    },
    "meaning": {
      "uz": "string",
      "ru": "string",
      "en": "string"
    },
    "origin": {
      "uz": "string",
      "ru": "string",
      "en": "string"
    },
    "culturalContext": {
      "uz": "string",
      "ru": "string",
      "en": "string"
    },
    "familyConnection": {
      "uz": "string",
      "ru": "string",
      "en": "string"
    },
    gender: "string" // boy, girl or both
    "popularityScore": number
  }
]
''';
  }
}
