import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/data/model/location_model.dart';
import 'package:weather_app/data/model/weather_model.dart';

class WeatherApiService {
  static final Dio _dio = Dio();

  static Future<WeatherModel?> fetchDataAna(LocationModel location) async {
    String apiUrl =
        'https://api.openweathermap.org/data/3.0/onecall?lat=${location.lat}&lon=${location.lon}&exclude=minutely,alerts&units=metric&APPID={APPID}}';

    try {
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data, location.name ?? '');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  static Future<List<LocationModel>?> searchLocation(String query) async {
    try {
      final response = await _dio.get(
        'https://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=cd5baa4c47f31a6314d3c92afa7fb872',
      );

      final List<LocationModel> matches = (response.data as List)
          .map((item) => LocationModel.fromJson(item))
          .toList();

      return matches;
    } catch (e) {
      return null;
    }
  }
}
