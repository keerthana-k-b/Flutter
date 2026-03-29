import 'package:flutter/material.dart' hide TimeOfDay;
import '../providers/weather_provider.dart' show TimeOfDay;

class WeatherTheme {
  final List<Color> skyGradient;
  final List<Color> cardGradient;
  final Color primaryText;
  final Color secondaryText;
  final Color cardBg;
  final Color cardBorder;
  final Color iconColor;
  final Color accentColor;
  final bool showMoon;
  final bool showSun;
  final String timeLabel;

  const WeatherTheme({
    required this.skyGradient,
    required this.cardGradient,
    required this.primaryText,
    required this.secondaryText,
    required this.cardBg,
    required this.cardBorder,
    required this.iconColor,
    required this.accentColor,
    required this.showMoon,
    required this.showSun,
    required this.timeLabel,
  });

  static WeatherTheme fromTimeOfDay(TimeOfDay tod) {
    switch (tod) {
      case TimeOfDay.dawn:
        return WeatherTheme(
          skyGradient: [
            const Color(0xFF1a0533),
            const Color(0xFF6b2d8b),
            const Color(0xFFe8824a),
            const Color(0xFFf7c59f),
          ],
          cardGradient: [const Color(0x336b2d8b), const Color(0x22e8824a)],
          primaryText: Colors.white,
          secondaryText: const Color(0xFFf7c59f),
          cardBg: const Color(0x336b2d8b),
          cardBorder: const Color(0x55e8824a),
          iconColor: const Color(0xFFf7c59f),
          accentColor: const Color(0xFFe8824a),
          showMoon: true,
          showSun: false,
          timeLabel: 'Dawn',
        );
      case TimeOfDay.morning:
        return WeatherTheme(
          skyGradient: [
            const Color(0xFF1a3a6b),
            const Color(0xFF3b7dd8),
            const Color(0xFF74b9f5),
            const Color(0xFFffd580),
          ],
          cardGradient: [const Color(0x333b7dd8), const Color(0x22ffd580)],
          primaryText: Colors.white,
          secondaryText: const Color(0xFFe0f0ff),
          cardBg: const Color(0x333b7dd8),
          cardBorder: const Color(0x55ffd580),
          iconColor: const Color(0xFFffd580),
          accentColor: const Color(0xFFffd580),
          showMoon: false,
          showSun: true,
          timeLabel: 'Morning',
        );
      case TimeOfDay.midday:
        return WeatherTheme(
          skyGradient: [
            const Color(0xFF0066cc),
            const Color(0xFF3399ff),
            const Color(0xFF66b3ff),
            const Color(0xFFcce5ff),
          ],
          cardGradient: [const Color(0x330066cc), const Color(0x2266b3ff)],
          primaryText: Colors.white,
          secondaryText: const Color(0xFFcce5ff),
          cardBg: const Color(0x330066cc),
          cardBorder: const Color(0x5566b3ff),
          iconColor: const Color(0xFFffe066),
          accentColor: const Color(0xFFffe066),
          showMoon: false,
          showSun: true,
          timeLabel: 'Midday',
        );
      case TimeOfDay.afternoon:
        return WeatherTheme(
          skyGradient: [
            const Color(0xFF0d47a1),
            const Color(0xFF1976d2),
            const Color(0xFF64b5f6),
            const Color(0xFFffe0b2),
          ],
          cardGradient: [const Color(0x330d47a1), const Color(0x2264b5f6)],
          primaryText: Colors.white,
          secondaryText: const Color(0xFFffe0b2),
          cardBg: const Color(0x330d47a1),
          cardBorder: const Color(0x5564b5f6),
          iconColor: const Color(0xFFffe0b2),
          accentColor: const Color(0xFFff9800),
          showMoon: false,
          showSun: true,
          timeLabel: 'Afternoon',
        );
      case TimeOfDay.dusk:
        return WeatherTheme(
          skyGradient: [
            const Color(0xFF1a0a3d),
            const Color(0xFF7b1fa2),
            const Color(0xFFff5722),
            const Color(0xFFffc107),
          ],
          cardGradient: [const Color(0x337b1fa2), const Color(0x22ff5722)],
          primaryText: Colors.white,
          secondaryText: const Color(0xFFffd54f),
          cardBg: const Color(0x337b1fa2),
          cardBorder: const Color(0x55ff5722),
          iconColor: const Color(0xFFffc107),
          accentColor: const Color(0xFFff5722),
          showMoon: false,
          showSun: true,
          timeLabel: 'Dusk',
        );
      case TimeOfDay.evening:
        return WeatherTheme(
          skyGradient: [
            const Color(0xFF0d0221),
            const Color(0xFF2d1b69),
            const Color(0xFF553c9a),
            const Color(0xFF8b6fc7),
          ],
          cardGradient: [const Color(0x332d1b69), const Color(0x22553c9a)],
          primaryText: Colors.white,
          secondaryText: const Color(0xFFb39ddb),
          cardBg: const Color(0x332d1b69),
          cardBorder: const Color(0x55553c9a),
          iconColor: const Color(0xFFe8d5ff),
          accentColor: const Color(0xFF7c4dff),
          showMoon: true,
          showSun: false,
          timeLabel: 'Evening',
        );
      case TimeOfDay.night:
      default:
        return WeatherTheme(
          skyGradient: [
            const Color(0xFF050B18),
            const Color(0xFF0D1B3E),
            const Color(0xFF1B2A5E),
            const Color(0xFF2C3E70),
          ],
          cardGradient: [const Color(0x220D1B3E), const Color(0x221B2A5E)],
          primaryText: Colors.white,
          secondaryText: const Color(0xFF8BA8D0),
          cardBg: const Color(0x1AFFFFFF),
          cardBorder: const Color(0x33FFFFFF),
          iconColor: const Color(0xFFB8D4F0),
          accentColor: const Color(0xFF4FC3F7),
          showMoon: true,
          showSun: false,
          timeLabel: 'Night',
        );
    }
  }
}
