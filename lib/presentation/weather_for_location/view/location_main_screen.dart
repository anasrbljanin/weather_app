import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/model/weather_model.dart';
import 'package:weather_app/presentation/weather_for_location//bloc/weather_cubit.dart';
import 'package:weather_app/presentation/weather_for_location/view/current_weather_widget.dart';
import 'package:weather_app/presentation/weather_for_location/view/daily_weather_widget.dart';
import 'package:weather_app/presentation/weather_for_location/view/hourly_weather_widget.dart';
import 'package:weather_app/presentation/search/search_widget.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WeatherCubit(WeatherModel()),
      child: BlocBuilder<WeatherCubit, WeatherModel>(
        builder: (context, weatherModel) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SearchWidget(
                      onItemSelected: (value) {
                        context.read<WeatherCubit>().getSearchedLocation(value);
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  CurrentWeatherWidget(
                    nameOfTheCity: weatherModel.nameOfTheCity,
                    weatherDescription: weatherModel.currentTemp?.description,
                    currentTemperature: weatherModel.currentTemp?.temperature,
                    highestTemperature:
                        weatherModel.dailyTemp?.first.highestTemperature,
                    lowestTemperature:
                        weatherModel.dailyTemp?.first.lowestTemperature,
                    currentTime: weatherModel.hourlyTemp?.first.time,
                  ),
                  HourlyWeatherWidget(
                    sunrise: weatherModel.sunrise,
                    sunset: weatherModel.sunset,
                    hourlyWeatherList: weatherModel.hourlyTemp,
                  ),
                  DailyWeatherWidget(
                      dailyWeatherList: weatherModel.dailyTemp?.sublist(1, 6))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
