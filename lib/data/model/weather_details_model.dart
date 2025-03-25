import 'package:equatable/equatable.dart';

class WeatherDetailsModel extends Equatable {
  const WeatherDetailsModel({
    this.time,
    this.description,
    this.highestTemperature,
    this.lowestTemperature,
    this.temperature,
  });

  final DateTime? time;
  final String? description;
  final int? highestTemperature;
  final int? lowestTemperature;
  final int? temperature;

  factory WeatherDetailsModel.fromJson(
          Map<String, dynamic> json, int? timezoneOffset) =>
      WeatherDetailsModel(
        time: DateTime.fromMillisecondsSinceEpoch(
                (json['dt'] as num).toInt() * 1000,
                isUtc: true)
            .add(
          Duration(seconds: timezoneOffset ?? 0),
        ),
        description: json['weather'][0]['main'] as String?,
        temperature: (json['temp'] as num?)?.toInt(),
      );

  factory WeatherDetailsModel.fromJsonForDaily(
          Map<String, dynamic> json, int? timezoneOffset) =>
      WeatherDetailsModel(
        time: DateTime.fromMillisecondsSinceEpoch(
                (json['dt'] as num).toInt() * 1000,
                isUtc: true)
            .add(Duration(seconds: timezoneOffset ?? 0)),
        description: json['weather'][0]['main'] as String?,
        highestTemperature: (json['temp']['max'] as num?)?.toInt(),
        lowestTemperature: (json['temp']['min'] as num?)?.toInt(),
      );

  @override
  List<Object?> get props => [
        time,
        description,
        highestTemperature,
        lowestTemperature,
        temperature,
      ];
}
