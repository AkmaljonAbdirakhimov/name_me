import '../../domain/domain.dart';

class AppConstants {
  static const questions = [
    Question(
      text: 'father_name_question',
      type: 'father_name',
      options: [], // Will handle this specially since it's text input
    ),
    Question(
      text: 'mother_name_question',
      type: 'mother_name',
      options: [], // Will handle this specially since it's text input
    ),
    Question(
      text: 'gender_question',
      type: 'gender',
      options: [
        'gender_boy',
        'gender_girl',
        'gender_neutral',
      ],
    ),
    Question(
      text: 'origin_question',
      type: 'origin',
      options: [
        'origin_uzbek',
        'origin_russian',
        'origin_turkish',
        'origin_persian',
        'origin_arabic',
        'origin_european',
        'origin_any',
      ],
    ),
    Question(
      text: 'qualities_question',
      type: 'qualities',
      options: [
        'quality_strength',
        'quality_grace',
        'quality_wisdom',
        'quality_nature',
        'quality_love',
        'quality_multiple',
      ],
    ),
    Question(
      text: 'style_question',
      type: 'style',
      options: [
        'style_traditional',
        'style_modern',
        'style_unique',
      ],
    ),
    Question(text: 'country_question', type: 'country', options: [
      "UZ",
      "AE",
      "AF",
      "AL",
      "AM",
      "AR",
      "AT",
      "AU",
      "AZ",
      "BA",
      "BD",
      "BE",
      "BG",
      "BH",
      "BN",
      "BO",
      "BR",
      "BY",
      "CA",
      "CH",
      "CL",
      "CN",
      "CO",
      "CR",
      "CU",
      "CY",
      "CZ",
      "DE",
      "DK",
      "DO",
      "DZ",
      "EC",
      "EE",
      "EG",
      "ES",
      "ET",
      "FI",
      "FR",
      "GB",
      "GE",
      "GH",
      "GR",
      "GT",
      "HK",
      "HN",
      "HR",
      "HU",
      "ID",
      "IE",
      "IL",
      "IN",
      "IQ",
      "IR",
      "KZ",
      "KG",
      "RU",
      "TM",
      "TJ"
    ])
  ];

  static const Map<String, String> namePreferences = {
    "gender_boy": "Baby Boy",
    "gender_girl": "Baby Girl",
    "gender_neutral": "Gender-Neutral Name",
    "origin_uzbek": "Uzbek/Central Asian",
    "origin_russian": "Russian/Slavic",
    "origin_turkish": "Turkish/Turkic",
    "origin_persian": "Persian/Iranian",
    "origin_arabic": "Arabic/Middle Eastern",
    "origin_european": "European",
    "origin_any": "Any Origin",
    "quality_strength": "Strength & Courage",
    "quality_grace": "Beauty & Grace",
    "quality_wisdom": "Knowledge & Wisdom",
    "quality_nature": "Connection to Nature",
    "quality_love": "Love & Harmony",
    "quality_multiple": "Rich in Multiple Meanings",
    "style_traditional": "Classic & Traditional",
    "style_modern": "Contemporary & Modern",
    "style_unique": "Distinctive & Unique",
  };

  static const Map<String, String> countries = {
    "UZ": "Uzbekistan",
    "AE": "United Arab Emirates",
    "AF": "Afghanistan",
    "AL": "Albania",
    "AM": "Armenia",
    "AR": "Argentina",
    "AT": "Austria",
    "AU": "Australia",
    "AZ": "Azerbaijan",
    "BA": "Bosnia and Herzegovina",
    "BD": "Bangladesh",
    "BE": "Belgium",
    "BG": "Bulgaria",
    "BH": "Bahrain",
    "BN": "Brunei",
    "BO": "Bolivia",
    "BR": "Brazil",
    "BY": "Belarus",
    "CA": "Canada",
    "CH": "Switzerland",
    "CL": "Chile",
    "CN": "China",
    "CO": "Colombia",
    "CR": "Costa Rica",
    "CU": "Cuba",
    "CY": "Cyprus",
    "CZ": "Czech Republic",
    "DE": "Germany",
    "DK": "Denmark",
    "DO": "Dominican Republic",
    "DZ": "Algeria",
    "EC": "Ecuador",
    "EE": "Estonia",
    "EG": "Egypt",
    "ES": "Spain",
    "ET": "Ethiopia",
    "FI": "Finland",
    "FR": "France",
    "GB": "United Kingdom",
    "GE": "Georgia",
    "GH": "Ghana",
    "GR": "Greece",
    "GT": "Guatemala",
    "HK": "Hong Kong",
    "HN": "Honduras",
    "HR": "Croatia",
    "HU": "Hungary",
    "ID": "Indonesia",
    "IE": "Ireland",
    "IL": "Israel",
    "IN": "India",
    "IQ": "Iraq",
    "IR": "Iran",
    "KZ": "Kazakhstan",
    "KG": "Kyrgyzstan",
    "RU": "Russia",
    "TM": "Turkmenistan",
    "TJ": "Tajikistan"
  };
}
