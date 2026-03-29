import 'package:flutter/foundation.dart';
import 'package:myapp20/model/weather_model.dart';
import 'package:myapp20/service/weather_service.dart';


class WeatherProvider extends ChangeNotifier{
  WeatherModel? weathers ;
  bool isLoading = false;

  final WeatherService _service = WeatherService();

  String selectedCity = "Kochi";

  Future<void> getWeather() async {
    isLoading = true;
    notifyListeners();

    try{
      weathers = await _service.fetchWeather(selectedCity);
    }catch(e){
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }

  void changeCity(String city){
    selectedCity = city;
    getWeather();
  }
}