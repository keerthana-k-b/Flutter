class WeatherModel {
  final double lat;
  final double lon;
  final int weatherId;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int groundLevel;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final int clouds;
  final int dt;
  final String country;
  final int sunrise;
  final int sunset;
  final int timezone;
  final String cityName;

  WeatherModel({
    required this.lat,
    required this.lon,
    required this.weatherId,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.groundLevel,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.clouds,
    required this.dt,
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.timezone,
    required this.cityName,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    final wind = json['wind'];
    final sys = json['sys'];
    return WeatherModel(
      lat: (json['coord']['lat'] as num).toDouble(),
      lon: (json['coord']['lon'] as num).toDouble(),
      weatherId: weather['id'],
      weatherMain: weather['main'],
      weatherDescription: weather['description'],
      weatherIcon: weather['icon'],
      temp: (main['temp'] as num).toDouble(),
      feelsLike: (main['feels_like'] as num).toDouble(),
      tempMin: (main['temp_min'] as num).toDouble(),
      tempMax: (main['temp_max'] as num).toDouble(),
      pressure: main['pressure'],
      humidity: main['humidity'],
      seaLevel: main['sea_level'] ?? main['pressure'],
      groundLevel: main['grnd_level'] ?? main['pressure'],
      visibility: json['visibility'],
      windSpeed: (wind['speed'] as num).toDouble(),
      windDeg: wind['deg'],
      windGust: wind['gust'] != null ? (wind['gust'] as num).toDouble() : 0.0,
      clouds: json['clouds']['all'],
      dt: json['dt'],
      country: sys['country'],
      sunrise: sys['sunrise'],
      sunset: sys['sunset'],
      timezone: json['timezone'],
      cityName: json['name'],
    );
  }

  double get tempCelsius => temp - 273.15;
  double get feelsLikeCelsius => feelsLike - 273.15;
  double get tempMinCelsius => tempMin - 273.15;
  double get tempMaxCelsius => tempMax - 273.15;

  /// Returns local DateTime based on timezone offset
  DateTime get localDateTime =>
      DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true)
          .add(Duration(seconds: timezone));

  DateTime get sunriseLocal =>
      DateTime.fromMillisecondsSinceEpoch(sunrise * 1000, isUtc: true)
          .add(Duration(seconds: timezone));

  DateTime get sunsetLocal =>
      DateTime.fromMillisecondsSinceEpoch(sunset * 1000, isUtc: true)
          .add(Duration(seconds: timezone));

  String get windDirection {
    const dirs = ['N','NNE','NE','ENE','E','ESE','SE','SSE','S','SSW','SW','WSW','W','WNW','NW','NNW'];
    return dirs[((windDeg % 360) / 22.5).round() % 16];
  }

  String formatTime(DateTime dt) {
    final h = dt.hour;
    final m = dt.minute.toString().padLeft(2, '0');
    final period = h >= 12 ? 'PM' : 'AM';
    final hour = h % 12 == 0 ? 12 : h % 12;
    return '$hour:$m $period';
  }

  String get sunriseFormatted => formatTime(sunriseLocal);
  String get sunsetFormatted => formatTime(sunsetLocal);
}

class HourlyForecast {
  final int dt;
  final double temp;
  final String description;
  final String icon;
  final int timezone;

  HourlyForecast({
    required this.dt,
    required this.temp,
    required this.description,
    required this.icon,
    required this.timezone,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json, int timezone) {
    return HourlyForecast(
      dt: json['dt'],
      temp: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      timezone: timezone,
    );
  }

  double get tempCelsius => temp - 273.15;

  DateTime get localTime =>
      DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true)
          .add(Duration(seconds: timezone));

  String get timeLabel {
    final h = localTime.hour;
    final period = h >= 12 ? 'PM' : 'AM';
    final hour = h % 12 == 0 ? 12 : h % 12;
    return '${hour}${period}';
  }
}
