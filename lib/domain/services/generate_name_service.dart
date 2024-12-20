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

        // Keep processing while we can find complete objects
        while (true) {
          // Find the start of a JSON object
          final startIndex = buffer.indexOf('{');
          if (startIndex == -1) break;

          // Track nested braces
          int braceCount = 0;
          int endIndex = -1;

          // Scan for matching closing brace
          for (int i = startIndex; i < buffer.length; i++) {
            if (buffer[i] == '{') braceCount++;
            if (buffer[i] == '}') braceCount--;

            if (braceCount == 0) {
              endIndex = i + 1;
              break;
            }
          }

          // If we didn't find a complete object, break and wait for more data
          if (endIndex == -1) break;

          // Try to parse the complete object
          try {
            final jsonStr = buffer.substring(startIndex, endIndex);
            final parsed = json.decode(jsonStr);
            final suggestion = NameSuggestion.fromMap(parsed);
            yield suggestion;

            // Remove the processed object from buffer
            buffer = buffer.substring(endIndex).trim();
          } catch (e) {
            log('Parse error: $e for JSON: ${buffer.substring(startIndex, endIndex)}');
            // Remove the problematic part and continue
            buffer = buffer.substring(endIndex).trim();
          }
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
