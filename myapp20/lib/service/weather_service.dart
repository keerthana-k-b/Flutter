import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp20/model/weather_model.dart';

class WeatherService {

  Future<WeatherModel> fetchWeather(String city) async {

    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=7c138ef7f392cbbf66d519f6e50e687b'),
    headers:{
    "Accept": "application/json",
    "User-Agent": "Flutter App"
    },

    );
   
    if(response.statusCode == 200){
      print(response.statusCode);

      final data = jsonDecode(response.body);

      return WeatherModel.fromJson(data);
    }else{
      throw Exception('Failed to load weather');
    }

    
  }
}