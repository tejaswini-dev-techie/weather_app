import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sky_sense/modules/weather_screen/models/weather_model.dart';
import 'package:sky_sense/utils/services/api_urls.dart';

class RestAPIService {
  /* Singleton Class */
  static final RestAPIService _serviceInstance = RestAPIService._internal();
  RestAPIService._internal();
  factory RestAPIService() => _serviceInstance;

  static int apiHitTimeout = 30;

  /* API Key */
  String apiKey = dotenv.get('API_KEY');

  /* Current Weather Service */
  Future<WeatherDataModel?> fetchCurrentWeatherDetails(
      {required String location}) async {
    final response = await http.post(
      Uri.parse(
        APIUrls.currentWeatherURL,
      ),
      body: <String, String>{
        'key': apiKey,
        'q': location,
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON.
      return WeatherDataModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      return null;
    } else {
      // If the server did not return a 200 OK response,
      // then throws an exception.
      throw Exception('Failed to load data');
    }
  }
  /* Current Weather Service */
}
