// country_list.dart
/*
Future<List<String>> fetchCountries() async {
  List<String> countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'India',
    'Germany',
    'France',
    'Japan',
    'China',
    'Brazil',
    'South Africa'
  ];

  return countries;
}
*/

import 'dart:convert';
import 'package:http/http.dart' as http;

// Passed in at build time: flutter run --dart-define-from-file=api_keys.json
// Note: Allow localhost for your key.
// Open https://restcountries.com/api-keys, open your key, and add localhost to its CORS allowed origins.
const String _apiKey = String.fromEnvironment('RESTCOUNTRIES_API_KEY');

// A DropdownButton fails unless its value is one of its items, so fall back to the first country.
String countryInList(String country, List<String> countries) {
  return countries.contains(country) || countries.isEmpty ? country : countries.first;
}

Future<List<String>> fetchCountries() async {
  // The key goes in the URL rather than an Authorization header, which a browser would block.
  final response = await http.get(Uri.parse(
      'https://api.restcountries.com/countries/v5?limit=100&api-key=$_apiKey'));

  if (response.statusCode == 200) {
    List<dynamic> countriesJson = json.decode(response.body)['data']['objects'];
    List<String> countryList = countriesJson
        .map((country) => country['names']['common'] as String)
        .toList();
    return countryList;
  } else {
    throw Exception('Failed to load countries');
  }
}
