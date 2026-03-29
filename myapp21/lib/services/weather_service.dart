// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/weather_model.dart';

// class WeatherService {
//   static const String _baseUrl = 'http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=7c138ef7f392cbbf66d519f6e50e687b';
//   // Replace with your actual OpenWeatherMap API key
//   static const String _apiKey = 'YOUR_API_KEY_HERE';

//   /// Fetches current weather by city name
//   Future<WeatherModel> fetchWeatherByCity(String city) async {
//     final uri = Uri.parse(
//       '$_baseUrl/weather?q=$city&appid=$_apiKey',
//     );
//     final response = await http.get(uri);
//     if (response.statusCode == 200) {
//       return WeatherModel.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to fetch weather: ${response.statusCode}');
//     }
//   }

//   /// Fetches current weather by coordinates
//   Future<WeatherModel> fetchWeatherByCoords(double lat, double lon) async {
//     final uri = Uri.parse(
//       '$_baseUrl/weather?lat=$lat&lon=$lon&appid=$_apiKey',
//     );
//     final response = await http.get(uri);
//     if (response.statusCode == 200) {
//       return WeatherModel.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to fetch weather: ${response.statusCode}');
//     }
//   }

//   /// Fetches 5-day / 3-hour hourly forecast
//   Future<List<HourlyForecast>> fetchHourlyForecast(double lat, double lon, int timezone) async {
//     final uri = Uri.parse(
//       '$_baseUrl/forecast?lat=$lat&lon=$lon&appid=$_apiKey&cnt=8',
//     );
//     final response = await http.get(uri);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final list = data['list'] as List;
//       return list.map((e) => HourlyForecast.fromJson(e, timezone)).toList();
//     } else {
//       throw Exception('Failed to fetch forecast: ${response.statusCode}');
//     }
//   }

//   /// Returns mock data (uses the JSON you provided) for offline/demo use
//   WeatherModel getMockWeather() {
//     return WeatherModel.fromJson({
//       "coord": {"lon": 76.2602, "lat": 9.9399},
//       "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}],
//       "base": "stations",
//       "main": {
//         "temp": 301.9,
//         "feels_like": 305.34,
//         "temp_min": 301.9,
//         "temp_max": 301.9,
//         "pressure": 1011,
//         "humidity": 70,
//         "sea_level": 1011,
//         "grnd_level": 1010
//       },
//       "visibility": 10000,
//       "wind": {"speed": 2.96, "deg": 254, "gust": 2.21},
//       "clouds": {"all": 9},
//       "dt": 1773728493,
//       "sys": {"country": "IN", "sunrise": 1773709267, "sunset": 1773752748},
//       "timezone": 19800,
//       "id": 1273874,
//       "name": "Kochi",
//       "cod": 200
//     });
//   }

//   List<HourlyForecast> getMockHourly(int timezone) {
//     final base = 1773728493;
//     final descriptions = ['clear sky', 'clear sky', 'few clouds', 'few clouds', 'clear sky', 'clear sky', 'clear sky', 'clear sky'];
//     final icons = ['01n', '01n', '02n', '02n', '01n', '01n', '01n', '01n'];
//     final temps = [302.0, 301.0, 301.0, 300.0, 300.0, 300.0, 299.5, 299.0];
//     return List.generate(8, (i) => HourlyForecast(
//       dt: base + i * 3600,
//       temp: temps[i],
//       description: descriptions[i],
//       icon: icons[i],
//       timezone: timezone,
//     ));
//   }
// }



import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {

  /// Base URL (NO API KEY)
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  /// 🌤 Fetch weather by city
  Future<WeatherModel> fetchWeatherByCity(String city) async {
    final uri = Uri.parse(
      '$_baseUrl/weather?q=$city',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch weather: ${response.statusCode}');
    }
  }

  /// 📍 Fetch by coordinates
  Future<WeatherModel> fetchWeatherByCoords(double lat, double lon) async {
    final uri = Uri.parse(
      '$_baseUrl/weather?lat=$lat&lon=$lon',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch weather: ${response.statusCode}');
    }
  }

  /// ⏱ Hourly forecast
  Future<List<HourlyForecast>> fetchHourlyForecast(
      double lat, double lon, int timezone) async {

    final uri = Uri.parse(
      '$_baseUrl/forecast?lat=$lat&lon=$lon&cnt=8',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final list = data['list'] as List;

      return list
          .map((e) => HourlyForecast.fromJson(e, timezone))
          .toList();
    } else {
      throw Exception('Failed to fetch forecast: ${response.statusCode}');
    }
  }

  /// 🧪 MOCK DATA (UNCHANGED)
  WeatherModel getMockWeather() {
    return WeatherModel.fromJson({
      "coord": {"lon": 76.2602, "lat": 9.9399},
      "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}],
      "base": "stations",
      "main": {
        "temp": 301.9,
        "feels_like": 305.34,
        "temp_min": 301.9,
        "temp_max": 301.9,
        "pressure": 1011,
        "humidity": 70,
        "sea_level": 1011,
        "grnd_level": 1010
      },
      "visibility": 10000,
      "wind": {"speed": 2.96, "deg": 254, "gust": 2.21},
      "clouds": {"all": 9},
      "dt": 1773728493,
      "sys": {"country": "IN", "sunrise": 1773709267, "sunset": 1773752748},
      "timezone": 19800,
      "id": 1273874,
      "name": "Kochi",
      "cod": 200
    });
  }

  List<HourlyForecast> getMockHourly(int timezone) {
    final base = 1773728493;
    final descriptions = ['clear sky', 'clear sky', 'few clouds', 'few clouds', 'clear sky', 'clear sky', 'clear sky', 'clear sky'];
    final icons = ['01n', '01n', '02n', '02n', '01n', '01n', '01n', '01n'];
    final temps = [302.0, 301.0, 301.0, 300.0, 300.0, 300.0, 299.5, 299.0];

    return List.generate(8, (i) => HourlyForecast(
      dt: base + i * 3600,
      temp: temps[i],
      description: descriptions[i],
      icon: icons[i],
      timezone: timezone,
    ));
  }
}