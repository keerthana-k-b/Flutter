import 'package:flutter/material.dart';
import '../theme/weather_theme.dart';
import '../models/weather_model.dart';
import 'dart:math' as math;

class WeatherCard extends StatelessWidget {
  final WeatherTheme theme;
  final Widget child;
  final EdgeInsets? padding;

  const WeatherCard({
    Key? key,
    required this.theme,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      padding: padding ?? const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.cardBorder, width: 1),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.cardBg,
            theme.cardBg.withOpacity(0.5),
          ],
        ),
      ),
      child: child,
    );
  }
}

class WindCard extends StatefulWidget {
  final WeatherTheme theme;
  final double speed;
  final String direction;
  final double gust;

  const WindCard({
    Key? key,
    required this.theme,
    required this.speed,
    required this.direction,
    required this.gust,
  }) : super(key: key);

  @override
  State<WindCard> createState() => _WindCardState();
}

class _WindCardState extends State<WindCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      theme: widget.theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Wind',
              style: TextStyle(
                  color: widget.theme.secondaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.speed.toStringAsFixed(2)} m/s',
                    style: TextStyle(
                      color: widget.theme.primaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '→ ${widget.direction}',
                    style: TextStyle(
                      color: widget.theme.secondaryText,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    'Gust ${widget.gust.toStringAsFixed(2)} m/s',
                    style: TextStyle(
                      color: widget.theme.secondaryText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (ctx, _) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: widget.theme.cardBorder, width: 1.5),
                        color: widget.theme.cardBg,
                      ),
                      child: Icon(Icons.navigation,
                          color: widget.theme.accentColor, size: 20),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HumidityCard extends StatelessWidget {
  final WeatherTheme theme;
  final int humidity;

  const HumidityCard({Key? key, required this.theme, required this.humidity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      theme: theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Humidity',
              style: TextStyle(
                  color: theme.secondaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Text(
            '$humidity%',
            style: TextStyle(
              color: theme.primaryText,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: humidity / 100.0,
              backgroundColor: theme.cardBorder,
              valueColor: AlwaysStoppedAnimation<Color>(theme.accentColor),
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }
}

class SunriseSunsetCard extends StatelessWidget {
  final WeatherTheme theme;
  final String label;
  final String time;
  final bool isSunrise;

  const SunriseSunsetCard({
    Key? key,
    required this.theme,
    required this.label,
    required this.time,
    required this.isSunrise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      theme: theme,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Icon(
            isSunrise ? Icons.wb_twilight : Icons.nights_stay_outlined,
            color: theme.accentColor,
            size: 26,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      color: theme.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.w500)),
              Text(
                time,
                style: TextStyle(
                  color: theme.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoTileCard extends StatelessWidget {
  final WeatherTheme theme;
  final String label;
  final String value;
  final IconData icon;

  const InfoTileCard({
    Key? key,
    required this.theme,
    required this.label,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      theme: theme,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  color: theme.secondaryText,
                  fontSize: 11,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: theme.primaryText,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class HourlyForecastCard extends StatelessWidget {
  final WeatherTheme theme;
  final List<HourlyForecast> forecasts;

  const HourlyForecastCard({
    Key? key,
    required this.theme,
    required this.forecasts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      theme: theme,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Hourly Forecast",
            style: TextStyle(
              color: theme.primaryText,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: forecasts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, i) {
                final f = forecasts[i];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(f.timeLabel,
                        style: TextStyle(
                            color: theme.secondaryText, fontSize: 11)),
                    const SizedBox(height: 6),
                    _weatherIcon(f.icon, theme),
                    const SizedBox(height: 4),
                    Text(
                      f.description
                          .split(' ')
                          .map((w) => w[0].toUpperCase() + w.substring(1))
                          .join('\n'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: theme.secondaryText,
                          fontSize: 9,
                          height: 1.2),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${f.temp.round()}K',
                      style: TextStyle(
                        color: theme.primaryText,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _weatherIcon(String icon, WeatherTheme theme) {
    IconData iconData;
    if (icon.contains('01')) {
      iconData = icon.contains('n') ? Icons.nights_stay : Icons.wb_sunny;
    } else if (icon.contains('02') || icon.contains('03')) {
      iconData = Icons.cloud;
    } else if (icon.contains('04')) {
      iconData = Icons.cloud_queue;
    } else if (icon.contains('09') || icon.contains('10')) {
      iconData = Icons.grain;
    } else if (icon.contains('11')) {
      iconData = Icons.thunderstorm;
    } else if (icon.contains('13')) {
      iconData = Icons.ac_unit;
    } else {
      iconData = Icons.blur_on;
    }
    return Icon(iconData, color: theme.iconColor, size: 22);
  }
}
