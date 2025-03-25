import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/model/location_model.dart';
import 'package:weather_app/data/model/weather_model.dart';
import 'package:weather_app/data/weather_api_service.dart';
import 'package:weather_app/design/strings.dart';

class WeatherCubit extends Cubit<WeatherModel> {
  WeatherCubit(super.initialState) {
    requestLocationPermission();
  }

  late WeatherModel? weatherModel;

  Future<void> requestLocationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      weatherModel =
          await WeatherApiService.fetchDataAna(LocationModel.defaultLocation);

    } else {
      Position position = await Geolocator.getCurrentPosition();
      weatherModel = await WeatherApiService.fetchDataAna(LocationModel(
          lat: position.latitude,
          lon: position.longitude,
          name: WeatherString.currentPosition));
    }
    emit(weatherModel!);
  }

  Future<void> getSearchedLocation(LocationModel location) async {
    weatherModel = await WeatherApiService.fetchDataAna(location);
    emit(weatherModel!);
  }
}
