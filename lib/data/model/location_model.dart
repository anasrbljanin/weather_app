import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  const LocationModel(
      {this.name, required this.lat, required this.lon, this.country});

  final String? name;
  final double lat;
  final double lon;
  final String? country;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
      name: json['name'],
      lat: json['lat'],
      lon: json['lon'],
      country: json['country']);

  static LocationModel get defaultLocation => LocationModel(
      name: 'Default location - Paris',
      lat: 44.804,
      lon: 20.4651,
      country: 'RS');

  @override
  List<Object?> get props => [name, lat, lon, country];
}
