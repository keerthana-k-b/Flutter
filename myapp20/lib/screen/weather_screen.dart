import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:myapp20/provider/weather_provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false).getWeather();
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<WeatherProvider>(context);

    if (provider.isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.weathers == null) {
      return Scaffold(
        body: Center(child: Text("No Data")),
      );
    }

    DateTime now = DateTime.now();

    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
        provider.weathers!.sys.sunrise * 1000);

    DateTime sunset = DateTime.fromMillisecondsSinceEpoch(
        provider.weathers!.sys.sunset * 1000);

    String newSunrise = DateFormat('hh:mm a').format(sunrise);
    String newSunset = DateFormat('hh:mm a').format(sunset);

    bool isDay = now.isAfter(sunrise) && now.isBefore(sunset);

    return Scaffold(
      body: Stack(
        children: [

          /// 🌈 BACKGROUND
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDay
                    ? [Color(0xFF4facfe), Color(0xFF00f2fe)]
                    : [Color(0xFF141E30), Color(0xFF243B55)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// 🎬 LOTTIE
          Positioned.fill(
            child: Lottie.asset(
              "assets/lottie/day_night.json",
              fit: BoxFit.cover,
            ),
          ),

          /// 🌗 OVERLAY
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(isDay ? 0.1 : 0.5),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔽 DROPDOWN (KEEPED)
                    DropdownButton<String>(
                      value: provider.selectedCity,
                      dropdownColor: Colors.black,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      underline: SizedBox(),

                      items: [
                        "Kochi",
                        "Trivandrum",
                        "Calicut",
                        "Delhi",
                        "Mumbai",
                      ].map((city) {
                        return DropdownMenuItem(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),

                      onChanged: (value) {
                        if (value != null) {
                          provider.changeCity(value);
                        }
                      },
                    ),

                    SizedBox(height: 10),

                    /// 📍 HEADER
                    Text(
                      "${provider.weathers!.name.toUpperCase()}",
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${provider.weathers!.sys.country}",
                      style: TextStyle(color: Colors.white70),
                    ),

                    SizedBox(height: 20),

                    /// 🌤 ICON + TEMP
                    Center(
                      child: Column(
                        children: [
                          Image.network(
                            "https://openweathermap.org/img/wn/${provider.weathers!.weather[0].icon}@4x.png",
                          ),

                          Text(
                            "${(provider.weathers!.main.temp- 273.15).toStringAsFixed(1)}°C",
                            style: TextStyle(fontSize: 60, color: Colors.white),
                          ),

                          Text(
                            provider.weathers!.weather[0].description,
                            style: TextStyle(color: Colors.white70),
                          ),

                          SizedBox(height: 5),

                          /// FEELS + MIN MAX (KEPT)
                          Text(
                            "Feels like ${(provider.weathers!.main.feelsLike - 273.15).toStringAsFixed(1)}°C",
                            style: TextStyle(color: Colors.white),
                          ),

                          Text(
                            "Low: ${(provider.weathers!.main.tempMin - 273.15).toStringAsFixed(1)}°C  |  High: ${(provider.weathers!.main.tempMax - 273.15).toStringAsFixed(1)}°C",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    /// 💧 HUMIDITY + 💨 WIND
                    Row(
                      children: [

                        Expanded(
                          child: glassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Humidity", style: TextStyle(color: Colors.white70)),
                                Text("${provider.weathers!.main.humidity}%",
                                    style: TextStyle(color: Colors.white, fontSize: 18)),

                                SizedBox(height: 8),

                                LinearProgressIndicator(
                                  value: provider.weathers!.main.humidity / 100,
                                  backgroundColor: Colors.white24,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          child: glassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Wind", style: TextStyle(color: Colors.white70)),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${provider.weathers!.wind.speed} m/s",
                                        style: TextStyle(color: Colors.white)),

                                    Transform.rotate(
                                      angle: provider.weathers!.wind.deg * (3.1416 / 180),
                                      child: Icon(Icons.navigation, color: Colors.blue),
                                    ),
                                  ],
                                ),

                                Text(
                                  "Gust ${(provider.weathers!.wind.gust ?? 0)} m/s",
                                  style: TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15),

                    /// 🌍 SMALL CARDS
                    Row(
                      children: [
                        Expanded(child: smallCard("Visibility", "${(provider.weathers!.visibility / 1000).toStringAsFixed(1)} km")),
                        Expanded(child: smallCard("Pressure", "${provider.weathers!.main.pressure} hPa")),
                        Expanded(child: smallCard("Sea Level",
                            provider.weathers!.main.seaLevel != null
                                ? "${provider.weathers!.main.seaLevel} hPa"
                                : "N/A")),
                      ],
                    ),

                    SizedBox(height: 15),

                    /// 🌅 SUN
                    Row(
                      children: [
                        Expanded(child: smallCard("Sunrise", newSunrise, icon: Icons.wb_sunny)),
                        Expanded(child: smallCard("Sunset", newSunset, icon: Icons.nightlight)),
                      ],
                    ),

                    SizedBox(height: 20),

                    /// 🗺 MAP
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage("assets/map.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🧊 GLASS CARD
  Widget glassCard({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  /// 🔳 SMALL CARD
  Widget smallCard(String title, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            if (icon != null) Icon(icon, color: Colors.orange, size: 18),
            Text(title, style: TextStyle(color: Colors.white70, fontSize: 12)),
            SizedBox(height: 4),
            Text(value, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}