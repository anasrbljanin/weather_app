class WeatherIcons {
  static const String snowIcon = 'assets/icons/snow.svg';
  static const String cloudyNightIcon = 'assets/icons/cloudy_night.svg';
  static const String cloudyIcon = 'assets/icons/cloudy.svg';
  static const String hazeIcon = 'assets/icons/haze.svg';
  static const String heavierThunderstormIcon =
      'assets/icons/heavier_thunderstorm.svg';
  static const String heavyRainIcon = 'assets/icons/heavy_rain.svg';
  static const String moonIcon = 'assets/icons/moon.svg';
  static const String rainyIcon = 'assets/icons/rainy.svg';
  static const String rainyDayIcon = 'assets/icons/rainy_day.svg';
  static const String rainyNightIcon = 'assets/icons/rainy_night.svg';
  static const String sunIcon = 'assets/icons/sun.svg';
  static const String sunnyIcon = 'assets/icons/sunny.svg';
  static const String sunnyCloudIcon = 'assets/icons/sunny_cloud.svg';
  static const String sunsetIcon = 'assets/icons/sunset.svg';
  static const String thunderstormIcon = 'assets/icons/thunderstorm.svg';
  static const String windyIcon = 'assets/icons/windy.svg';
  static const String windyDayIcon = 'assets/icons/windy_day.svg';
  static const String windyNightIcon = 'assets/icons/windy_night.svg';

  static String weatherIcon(String weatherDescription,
      {bool isDaytime = true}) {
    switch (weatherDescription) {
      case 'Clouds':
      case 'Mist':
        return cloudyIcon;
      case 'Clear':
        return isDaytime ? sunIcon : moonIcon;
      case 'Snow':
        return snowIcon;
      case 'Drizzle':
        return isDaytime ? rainyDayIcon : rainyNightIcon;
      case 'Rain':
        return heavyRainIcon;
      default:
        return rainyNightIcon;
    }
  }
}
