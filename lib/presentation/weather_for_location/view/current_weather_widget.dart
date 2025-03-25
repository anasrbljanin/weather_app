import 'package:flutter/material.dart';
import 'package:weather_app/design/colors.dart';
import 'package:weather_app/design/strings.dart';
import 'package:weather_app/design/text_styles.dart';
import 'package:weather_app/presentation/commons/dates_helper.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({
    required this.nameOfTheCity,
    required this.weatherDescription,
    required this.currentTemperature,
    required this.highestTemperature,
    required this.lowestTemperature,
    required this.currentTime,
    super.key,
  });

  final String? nameOfTheCity;
  final String? weatherDescription;
  final int? currentTemperature;
  final int? highestTemperature;
  final int? lowestTemperature;
  final DateTime? currentTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: WeatherColor.backgroundBlue,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: WeatherColor.highlightBlue,
                    size: 24,
                  ),
                  Text(
                      nameOfTheCity != null
                          ? nameOfTheCity!
                          : WeatherString.noLocation,
                      style: WeatherTextStyle.defaultTextStyle(
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  Text('${WeatherString.today} ${currentTime.formatTime()}',
                      //getter for time
                      style: WeatherTextStyle.defaultTextStyle()),
                ],
              )
            ],
          ),
          if (currentTemperature != null)
            Text('$currentTemperature°',
                style: WeatherTextStyle.defaultTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 100,
                )),
          if (weatherDescription != null)
            Text(weatherDescription!,
                style: WeatherTextStyle.defaultTextStyle()),
          Text('H:$highestTemperature° L:$lowestTemperature°',
              style: WeatherTextStyle.defaultTextStyle()),
        ],
      ),
    );
  }
}
