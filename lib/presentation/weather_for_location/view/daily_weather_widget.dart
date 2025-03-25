import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/design/strings.dart';
import 'package:weather_app/presentation/commons/dates_helper.dart';
import 'package:weather_app/data/model/weather_details_model.dart';
import 'package:weather_app/design/colors.dart';
import 'package:weather_app/design/icons.dart';
import 'package:weather_app/design/text_styles.dart';

class DailyWeatherWidget extends StatelessWidget {
  const DailyWeatherWidget({required this.dailyWeatherList, super.key});

  final List<WeatherDetailsModel>? dailyWeatherList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          WeatherString.nextFiveDays,
          style: WeatherTextStyle.header(),
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
            child: dailyWeatherList == null || dailyWeatherList!.isEmpty
                ? Text(WeatherString.noData)
                : Column(
                    children: _getDays,
                  )),
      ],
    );
  }

  List<Widget> get _getDays {
    List<Widget> days = [];
    for (WeatherDetailsModel day in dailyWeatherList!) {
      days.add(DayWeather(day: day));
    }
    return days;
  }
}

class DayWeather extends StatelessWidget {
  const DayWeather({required this.day, super.key});

  final WeatherDetailsModel day;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateHelper.getWeekdayString(day.time?.weekday),
                    style: WeatherTextStyle.defaultTextStyle(
                        fontWeight: FontWeight.w500,
                        color: WeatherColor.labelBlack),
                  ),
                  Text(
                    '${day.time?.day} ${DateHelper.getMonthString(day.time?.month)}',
                    style: WeatherTextStyle.defaultTextStyle(
                        fontWeight: FontWeight.w400, color: WeatherColor.labelGrey),
                  )
                ],
              ),
            ),
            Expanded(
              child: SvgPicture.asset(
                WeatherIcons.weatherIcon(day.description ?? ''),
                width: 40,
                height: 40,
              ),
            ),
            Expanded(
                child: Text(
              textAlign: TextAlign.end,
              'L: ${day.lowestTemperature}° H: ${day.highestTemperature}°',
              style: WeatherTextStyle.defaultTextStyle(
                  color: WeatherColor.labelBlack, fontWeight: FontWeight.w400),
            )),
          ],
        ),
        SizedBox(height: 16,)
      ],
    );
  }
}
