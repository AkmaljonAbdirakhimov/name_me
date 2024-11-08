import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:name_me/utils/utils.dart';

import '../domain.dart';

class NameRepositoryImpl implements NameRepository {
  final GenerativeModel _model;

  NameRepositoryImpl(this._model);

  @override
  Future<List<NameSuggestion>> getNameSuggestions(
    NamePreference preferences,
  ) async {
    try {
      final prompt = _buildPrompt(preferences);
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return _parseResponse(response.text ?? '');
    } catch (e, stack) {
      print(e);
      print(stack);
      throw Exception('Failed to generate names: $e');
    }
  }

  @override
  Stream<NameSuggestion> streamNameSuggestions(
    NamePreference preferences,
  ) async* {
    try {
      final prompt = _buildPrompt(preferences);
      final content = [Content.text(prompt)];

      String buffer = '';
      await for (final response in _model.generateContentStream(content)) {
        final text = response.text ?? '';
        buffer += text;

        print(text);

        final startIndex = buffer.indexOf('[');
        final endIndex = buffer.lastIndexOf(']');

        try {
          if (startIndex != -1 && endIndex != -1) {
            print(buffer.substring(startIndex, endIndex + 1));
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
          print('Error parsing remaining buffer: $e');
          continue;
        }
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      throw Exception('Failed to generate names: $e');
    }
  }

  String _buildPrompt(NamePreference preferences) {
    return '''
You are a baby name expert specializing in names from ${preferences.country}. 
You must respond ONLY with a JSON containing 5 name suggestions.
Each response must be a valid, complete JSON array that can be parsed independently.
Do not include any explanatory text before or after the JSON.

Format each name suggestion using exactly this structure:
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
    "popularityScore": number
  }
]

Consider these requirements when generating names:
- Gender: ${AppConstants.namePreferences[preferences.gender]}
- Origin: ${AppConstants.namePreferences[preferences.origin]}
- Qualities: ${AppConstants.namePreferences[preferences.qualities]}
- Style: ${AppConstants.namePreferences[preferences.style]}
- Country Context: ${preferences.country}
${preferences.additionalNotes != null ? '- Additional Notes: ${preferences.additionalNotes}' : ''}

Parent Information:
- Father's Name: ${preferences.fatherName}
- Mother's Name: ${preferences.motherName}

Important Constraints:
1. Each name should respect ${preferences.country}'s cultural context
2. Names should have meaningful connections to parents' names where possible
3. Consider local naming traditions
4. Popularity score must be between 0-100
5. All translations must be provided in Uzbek (uz), Russian (ru), and English (en)

Remember: Give each name suggestion ONLY with the JSON array in total 5 names. No additional text.
''';
  }

  List<NameSuggestion> _parseResponse(String response) {
    try {
      if (response.startsWith('```json')) {
        response = response.substring(7, response.length - 3);
      }
      print(response);
      final List<dynamic> parsed = json.decode(response);
      return parsed.map((json) => NameSuggestion.fromMap(json)).toList();
    } catch (e, stack) {
      print(e);
      print(stack);
      throw Exception('Failed to parse AI response: $e');
    }
  }

  // Helper method to try parsing individual JSON objects from text
  List<NameSuggestion> _tryParseJson(String text) {
    try {
      if (text.trim().startsWith('[') && text.trim().endsWith(']')) {
        final List<dynamic> parsed = json.decode(text);
        return parsed.map((json) => NameSuggestion.fromMap(json)).toList();
      }
    } catch (e) {
      print('Error parsing JSON: $e');
    }
    return [];
  }
}
