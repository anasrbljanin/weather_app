import 'package:equatable/equatable.dart';
import 'package:weather_app/data/model/weather_details_model.dart';

class WeatherModel extends Equatable {
  const WeatherModel({
    this.nameOfTheCity,
    this.currentTemp,
    this.sunrise,
    this.sunset,
    this.hourlyTemp,
    this.dailyTemp,
  });

  final String? nameOfTheCity;
  final WeatherDetailsModel? currentTemp;
  final DateTime? sunrise;
  final DateTime? sunset;
  final List<WeatherDetailsModel>? hourlyTemp;
  final List<WeatherDetailsModel>? dailyTemp;

  factory WeatherModel.fromJson(
          Map<String, dynamic> json, String nameOfTheCity) =>
      WeatherModel(
        nameOfTheCity: nameOfTheCity,
        currentTemp: WeatherDetailsModel.fromJson(
            json['current'], json['timezone_offset']),
        sunrise: DateTime.fromMillisecondsSinceEpoch(
                (json['current']['sunrise'] as num).toInt() * 1000,
                isUtc: true)
            .add(
          Duration(seconds: json['timezone_offset'] ?? 0),
        ),
        sunset: DateTime.fromMillisecondsSinceEpoch(
                (json['current']['sunset'] as num).toInt() * 1000,
                isUtc: true)
            .add(
          Duration(seconds: json['timezone_offset'] ?? 0),
        ),
        hourlyTemp: (json['hourly'] as List)
            .sublist(0, 24)
            .map(
              (e) => WeatherDetailsModel.fromJson(e, json['timezone_offset']),
            )
            .toList(),
        dailyTemp: (json['daily'] as List)
            .map((e) => WeatherDetailsModel.fromJsonForDaily(
                e, json['timezone_offset']))
            .toList(),
      );

  WeatherModel copyWith(
      {String? nameOfTheCity,
      WeatherDetailsModel? currentTemp,
      DateTime? sunrise,
      DateTime? sunset,
      List<WeatherDetailsModel>? hourlyTemp,
      List<WeatherDetailsModel>? dailyTemp}) {
    return WeatherModel(
        nameOfTheCity: nameOfTheCity ?? this.nameOfTheCity,
        currentTemp: currentTemp ?? this.currentTemp,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
        hourlyTemp: hourlyTemp ?? this.hourlyTemp,
        dailyTemp: dailyTemp ?? this.dailyTemp);
  }

  @override
  List<Object?> get props =>
      [nameOfTheCity, currentTemp, sunrise, sunset, hourlyTemp, dailyTemp];
}
