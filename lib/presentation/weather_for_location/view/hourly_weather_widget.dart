import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/data/model/weather_details_model.dart';
import 'package:weather_app/design/colors.dart';
import 'package:weather_app/design/icons.dart';
import 'package:weather_app/design/strings.dart';
import 'package:weather_app/design/text_styles.dart';
import 'package:weather_app/presentation/commons/dates_helper.dart';

class HourlyWeatherWidget extends StatelessWidget {
  const HourlyWeatherWidget({
    required this.sunrise,
    required this.sunset,
    required this.hourlyWeatherList,
    super.key,
  });

  final DateTime? sunrise;
  final DateTime? sunset;
  final List<WeatherDetailsModel>? hourlyWeatherList;

  @override
  Widget build(BuildContext context) {
    if (hourlyWeatherList == null || hourlyWeatherList!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Text(WeatherString.noData, style: WeatherTextStyle.header()),
      );
    }

    List<WeatherDetailsModel> modifiedList = getModifiedList;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            WeatherString.next24Hours,
            style: WeatherTextStyle.header(),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: modifiedList.length,
              itemBuilder: (BuildContext context, int index) {
                final weather = modifiedList[index];

                if (weather.description == WeatherString.sunrise) {
                  return HourWidget(
                    time: weather.time!.formatTime(),
                    icon: WeatherIcons.sunsetIcon,
                    temperatureLabel: WeatherString.sunrise,
                  );
                }
                if (weather.description == WeatherString.sunset) {
                  return HourWidget(
                    time: weather.time!.formatTime(),
                    icon: WeatherIcons.sunsetIcon,
                    temperatureLabel: WeatherString.sunset,
                  );
                }

                return HourWidget(
                  time: index == 0
                      ? WeatherString.now
                      : weather.time!.hour.toString(),
                  icon: WeatherIcons.weatherIcon(
                    weather.description ?? '',
                    isDaytime: weather.time!.isBetween(sunrise, sunset),
                  ),
                  temperatureLabel: '${weather.temperature}°',
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 24);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<WeatherDetailsModel> get getModifiedList {
    List<WeatherDetailsModel> modifiedList = [];
    for (int i = 0; i < hourlyWeatherList!.length - 1; i++) {
      final current = hourlyWeatherList![i];
      final next = hourlyWeatherList![i + 1];

      modifiedList.add(current);

      if (sunrise != null && sunrise!.isBetween(current.time!, next.time!)) {
        modifiedList.add(WeatherDetailsModel(
          time: sunrise,
          description: WeatherString.sunrise,
          temperature: null,
        ));
      }
      if (sunset != null && sunset!.isBetween(current.time!, next.time!)) {
        modifiedList.add(WeatherDetailsModel(
          time: sunset,
          description: WeatherString.sunset,
          temperature: null,
        ));
      }
    }

    modifiedList.add(hourlyWeatherList!.last);
    return modifiedList;
  }
}

class HourWidget extends StatelessWidget {
  const HourWidget({
    required this.time,
    required this.icon,
    required this.temperatureLabel,
    super.key,
  });

  final String time;
  final String icon;
  final String temperatureLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          time,
          style: WeatherTextStyle.defaultTextStyle(
              color: WeatherColor.labelBlack, fontSize: 12),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SvgPicture.asset(
            icon,
            width: 32,
            height: 32,
          ),
        ),
        Text(
          temperatureLabel,
          style:
              WeatherTextStyle.defaultTextStyle(color: WeatherColor.labelBlack),
        ),
      ],
    );
  }
}
