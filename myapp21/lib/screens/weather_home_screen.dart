import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../theme/weather_theme.dart';
import '../widgets/sky_background.dart';
import '../widgets/weather_cards.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({Key? key}) : super(key: key);

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _entryController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _entryController, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().loadWeather().then((_) {
        _entryController.forward();
      });
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final tod = provider.timeOfDayCategory;
    final theme = WeatherTheme.fromTimeOfDay(tod);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: Colors.black,
      body: SkyBackground(
        theme: theme,
        child: SafeArea(
          child: Column(
            children: [
              // App bar
              _buildAppBar(theme, provider),
              // Content
              Expanded(
                child: _buildBody(provider, theme),
              ),
              // Bottom Nav
              _buildBottomNav(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(WeatherTheme theme, WeatherProvider provider) {
    final w = provider.weather;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    (w?.cityName ?? 'KOCHI').toUpperCase(),
                    style: TextStyle(
                      color: theme.primaryText,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down,
                      color: theme.primaryText, size: 20),
                ],
              ),
              Text(
                w != null
                    ? '${w.country}, ${w.timezone} TZ'
                    : 'Ernakulam, KL',
                style:
                    TextStyle(color: theme.secondaryText, fontSize: 12),
              ),
            ],
          ),
          Row(
            children: [
              _iconBtn(Icons.search, theme, () {}),
              const SizedBox(width: 12),
              _iconBtn(Icons.settings_outlined, theme, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, WeatherTheme theme, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.cardBg,
          border: Border.all(color: theme.cardBorder),
        ),
        child: Icon(icon, color: theme.primaryText, size: 18),
      ),
    );
  }

  Widget _buildBody(WeatherProvider provider, WeatherTheme theme) {
    if (provider.status == WeatherStatus.loading ||
        provider.status == WeatherStatus.initial) {
      return Center(
        child: CircularProgressIndicator(color: theme.accentColor),
      );
    }
    if (provider.status == WeatherStatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off, color: theme.secondaryText, size: 50),
            const SizedBox(height: 12),
            Text(provider.errorMessage,
                style: TextStyle(color: theme.secondaryText)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: provider.refresh,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final w = provider.weather!;
    return FadeTransition(
      opacity: _fadeIn,
      child: SlideTransition(
        position: _slideUp,
        child: RefreshIndicator(
          color: theme.accentColor,
          onRefresh: provider.refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Main weather display
                _buildMainWeatherDisplay(w, theme),
                const SizedBox(height: 20),
                // Humidity + Wind row
                Row(
                  children: [
                    Expanded(child: HumidityCard(theme: theme, humidity: w.humidity)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: WindCard(
                        theme: theme,
                        speed: w.windSpeed,
                        direction: w.windDirection,
                        gust: w.windGust,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Visibility + Pressure + SeaLevel row
                Row(
                  children: [
                    Expanded(
                      child: InfoTileCard(
                        theme: theme,
                        label: 'Visibility',
                        value: '${(w.visibility / 1000).toStringAsFixed(1)} km',
                        icon: Icons.visibility_outlined,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InfoTileCard(
                        theme: theme,
                        label: 'Clouds',
                        value: '${w.clouds}% Coverage',
                        icon: Icons.cloud_outlined,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InfoTileCard(
                        theme: theme,
                        label: 'Sea Level',
                        value: '${w.seaLevel} hPa',
                        icon: Icons.waves_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Sunrise / Sunset
                Row(
                  children: [
                    Expanded(
                      child: SunriseSunsetCard(
                        theme: theme,
                        label: 'Sunrise:',
                        time: w.sunriseFormatted,
                        isSunrise: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SunriseSunsetCard(
                        theme: theme,
                        label: 'Sunset:',
                        time: w.sunsetFormatted,
                        isSunrise: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Hourly forecast
                if (provider.hourly.isNotEmpty)
                  HourlyForecastCard(
                      theme: theme, forecasts: provider.hourly),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainWeatherDisplay(weather, WeatherTheme theme) {
    return Column(
      children: [
        // Condition
        Text(
          weather.weatherDescription
              .split(' ')
              .map((w) => '${w[0].toUpperCase()}${w.substring(1)}')
              .join(' '),
          style: TextStyle(
            color: theme.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'dt converted to ~${weather.localDateTime.hour}:${weather.localDateTime.minute.toString().padLeft(2, '0')} ${weather.localDateTime.hour >= 12 ? "PM" : "AM"} local',
          style: TextStyle(color: theme.secondaryText, fontSize: 11),
        ),
        const SizedBox(height: 8),
        // Big temp
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${weather.temp.round()} K',
              style: TextStyle(
                color: theme.primaryText,
                fontSize: 72,
                fontWeight: FontWeight.w900,
                height: 1.0,
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                '${weather.tempCelsius.round()}°C',
                style: TextStyle(
                  color: theme.secondaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Feels like ${weather.feelsLike.round()}K',
          style: TextStyle(color: theme.secondaryText, fontSize: 13),
        ),
        Text(
          'Low: ${weather.tempMin.round()}K / High: ${weather.tempMax.round()}K',
          style: TextStyle(color: theme.secondaryText, fontSize: 12),
        ),
        const SizedBox(height: 4),
        // Pressure pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: theme.cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.cardBorder),
          ),
          child: Text(
            '${weather.pressure} hPa',
            style: TextStyle(
              color: theme.primaryText,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav(WeatherTheme theme) {
    final tabs = [
      (Icons.home_filled, 'Home'),
      (Icons.map_outlined, 'Map'),
      (Icons.radar, 'Radar'),
      (Icons.settings_outlined, 'Settings'),
    ];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      decoration: BoxDecoration(
        color: theme.cardBg,
        border: Border(top: BorderSide(color: theme.cardBorder)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (i) {
          final selected = _selectedTab == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: selected ? theme.accentColor.withOpacity(0.18) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    tabs[i].$1,
                    color: selected ? theme.accentColor : theme.secondaryText,
                    size: 22,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tabs[i].$2,
                    style: TextStyle(
                      color: selected ? theme.accentColor : theme.secondaryText,
                      fontSize: 10,
                      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}