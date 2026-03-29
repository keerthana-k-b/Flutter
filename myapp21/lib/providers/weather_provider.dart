// import 'package:flutter/material.dart';
// import 'package:myapp21/models/weather_model.dart';
// import 'package:myapp21/services/weather_service.dart';


// enum WeatherStatus { initial, loading, loaded, error }

// class WeatherProvider extends ChangeNotifier {
//   final WeatherService _service = WeatherService();

//   WeatherStatus _status = WeatherStatus.initial;
//   WeatherModel? _weather;
//   List<HourlyForecast> _hourly = [];
//   String _errorMessage = '';
//   String _currentCity = 'Kochi';

//   WeatherStatus get status => _status;
//   WeatherModel? get weather => _weather;
//   List<HourlyForecast> get hourly => _hourly;
//   String get errorMessage => _errorMessage;
//   String get currentCity => _currentCity;

//   /// Load weather for a city (falls back to mock if API key not set)
//   Future<void> loadWeather([String city = 'Kochi']) async {
//     _status = WeatherStatus.loading;
//     _currentCity = city;
//     notifyListeners();
//     try {
//       // If API key is not set, use mock data
//       if (WeatherService._apiKey == 'YOUR_API_KEY_HERE') {
//         await Future.delayed(const Duration(milliseconds: 800)); // simulate network
//         _weather = _service.getMockWeather();
//         _hourly = _service.getMockHourly(_weather!.timezone);
//       } else {
//         _weather = await _service.fetchWeatherByCity(city);
//         _hourly = await _service.fetchHourlyForecast(
//           _weather!.lat, _weather!.lon, _weather!.timezone);
//       }
//       _status = WeatherStatus.loaded;
//     } catch (e) {
//       _errorMessage = e.toString();
//       _status = WeatherStatus.error;
//     }
//     notifyListeners();
//   }

//   Future<void> refresh() => loadWeather(_currentCity);

//   /// Returns the time-of-day category for theming
//   TimeOfDay get timeOfDayCategory {
//     if (_weather == null) return _systemTimeOfDay();
//     final now = _weather!.localDateTime;
//     final hour = now.hour;
//     if (hour >= 5 && hour < 7) return TimeOfDay.dawn;
//     if (hour >= 7 && hour < 11) return TimeOfDay.morning;
//     if (hour >= 11 && hour < 14) return TimeOfDay.midday;
//     if (hour >= 14 && hour < 17) return TimeOfDay.afternoon;
//     if (hour >= 17 && hour < 20) return TimeOfDay.dusk;
//     if (hour >= 20 && hour < 22) return TimeOfDay.evening;
//     return TimeOfDay.night;
//   }

//   TimeOfDay _systemTimeOfDay() {
//     final hour = DateTime.now().hour;
//     if (hour >= 5 && hour < 7) return TimeOfDay.dawn;
//     if (hour >= 7 && hour < 11) return TimeOfDay.morning;
//     if (hour >= 11 && hour < 14) return TimeOfDay.midday;
//     if (hour >= 14 && hour < 17) return TimeOfDay.afternoon;
//     if (hour >= 17 && hour < 20) return TimeOfDay.dusk;
//     if (hour >= 20 && hour < 22) return TimeOfDay.evening;
//     return TimeOfDay.night;
//   }
// }

// enum TimeOfDay { dawn, morning, midday, afternoon, dusk, evening, night }


import 'package:flutter/material.dart';
import 'package:myapp21/models/weather_model.dart';
import 'package:myapp21/services/weather_service.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final WeatherService _service = WeatherService();

  WeatherStatus _status = WeatherStatus.initial;
  WeatherModel? _weather;
  List<HourlyForecast> _hourly = [];
  String _errorMessage = '';
  String _currentCity = 'Kochi';

  WeatherStatus get status => _status;
  WeatherModel? get weather => _weather;
  List<HourlyForecast> get hourly => _hourly;
  String get errorMessage => _errorMessage;
  String get currentCity => _currentCity;

  /// 🔥 Load weather (NO API KEY LOGIC)
  Future<void> loadWeather([String city = 'Kochi']) async {
    _status = WeatherStatus.loading;
    _currentCity = city;
    notifyListeners();

    try {
      /// ✅ DIRECT API CALL
      _weather = await _service.fetchWeatherByCity(city);

      _hourly = await _service.fetchHourlyForecast(
        _weather!.lat,
        _weather!.lon,
        _weather!.timezone,
      );

      _status = WeatherStatus.loaded;
    } catch (e) {
      /// ✅ FALLBACK TO MOCK (OPTIONAL BUT VERY USEFUL)
      _weather = _service.getMockWeather();
      _hourly = _service.getMockHourly(_weather!.timezone);

      _errorMessage = e.toString();
      _status = WeatherStatus.loaded; // still show UI
    }

    notifyListeners();
  }

  Future<void> refresh() => loadWeather(_currentCity);

  /// 🌗 Time category (UNCHANGED)
  TimeOfDay get timeOfDayCategory {
    if (_weather == null) return _systemTimeOfDay();

    final now = _weather!.localDateTime;
    final hour = now.hour;

    

    if (hour >= 5 && hour < 7) return TimeOfDay.dawn;
    if (hour >= 7 && hour < 11) return TimeOfDay.morning;
    if (hour >= 11 && hour < 14) return TimeOfDay.midday;
    if (hour >= 14 && hour < 17) return TimeOfDay.afternoon;
    if (hour >= 17 && hour < 20) return TimeOfDay.dusk;
    if (hour >= 20 && hour < 22) return TimeOfDay.evening;

    return TimeOfDay.night;
  }

  TimeOfDay _systemTimeOfDay() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 7) return TimeOfDay.dawn;
    if (hour >= 7 && hour < 11) return TimeOfDay.morning;
    if (hour >= 11 && hour < 14) return TimeOfDay.midday;
    if (hour >= 14 && hour < 17) return TimeOfDay.afternoon;
    if (hour >= 17 && hour < 20) return TimeOfDay.dusk;
    if (hour >= 20 && hour < 22) return TimeOfDay.evening;

    return TimeOfDay.night;
  }
}

enum TimeOfDay { dawn, morning, midday, afternoon, dusk, evening, night }