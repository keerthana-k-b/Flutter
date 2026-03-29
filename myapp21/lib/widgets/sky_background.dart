import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/weather_theme.dart';

class SkyBackground extends StatefulWidget {
  final WeatherTheme theme;
  final Widget child;

  const SkyBackground({Key? key, required this.theme, required this.child})
      : super(key: key);

  @override
  State<SkyBackground> createState() => _SkyBackgroundState();
}

class _SkyBackgroundState extends State<SkyBackground>
    with TickerProviderStateMixin {
  late AnimationController _twinkleController;
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _twinkleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _twinkleController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: widget.theme.skyGradient,
          stops: const [0.0, 0.35, 0.7, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Stars (night/evening/dawn only)
          if (widget.theme.showMoon) ..._buildStars(),
          // Moon or Sun
          if (widget.theme.showMoon) _buildMoon(),
          if (widget.theme.showSun) _buildSun(),
          // Palm tree silhouettes
          _buildPalmTrees(),
          // Main content
          widget.child,
        ],
      ),
    );
  }

  Widget _buildMoon() {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, _) {
        final offset = _floatController.value * 6;
        return Positioned(
          top: 60 - offset,
          right: 80,
          child: AnimatedOpacity(
            opacity: widget.theme.showMoon ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white,
                    const Color(0xFFE8E8D0),
                    const Color(0xFFD0D0B0).withOpacity(0.8),
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: CustomPaint(painter: _MoonCraterPainter()),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSun() {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, _) {
        final offset = _floatController.value * 5;
        return Positioned(
          top: 55 - offset,
          right: 70,
          child: AnimatedOpacity(
            opacity: widget.theme.showSun ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            child: Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white,
                    const Color(0xFFFFE566),
                    const Color(0xFFFFB300).withOpacity(0.6),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFE566).withOpacity(0.5),
                    blurRadius: 40,
                    spreadRadius: 15,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildStars() {
    final rng = math.Random(42);
    return List.generate(35, (i) {
      final x = rng.nextDouble();
      final y = rng.nextDouble() * 0.4;
      final size = rng.nextDouble() * 2.5 + 1.0;
      final delay = rng.nextDouble();
      return AnimatedBuilder(
        animation: _twinkleController,
        builder: (context, _) {
          final t = (_twinkleController.value + delay) % 1.0;
          final opacity = 0.4 + 0.6 * math.sin(t * math.pi);
          return Positioned(
            left: MediaQuery.of(context).size.width * x,
            top: MediaQuery.of(context).size.height * y * 0.55,
            child: Opacity(
              opacity: opacity,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: size * 2,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildPalmTrees() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 180,
        child: CustomPaint(painter: _PalmTreePainter()),
      ),
    );
  }
}

class _MoonCraterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFBBBB99).withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.3), 8, paint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.5), 5, paint);
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.65), 6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PalmTreePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.65)
      ..style = PaintingStyle.fill;

    void drawPalm(double baseX, double scale, double lean) {
      final path = Path();
      // Trunk
      path.moveTo(baseX, size.height);
      path.quadraticBezierTo(
        baseX + lean * 15 * scale,
        size.height * 0.5,
        baseX + lean * 30 * scale,
        size.height * 0.05,
      );
      path.lineTo(baseX + lean * 30 * scale + 8 * scale, size.height * 0.05);
      path.quadraticBezierTo(
        baseX + lean * 15 * scale + 8 * scale,
        size.height * 0.5,
        baseX + 12 * scale,
        size.height,
      );
      path.close();
      canvas.drawPath(path, paint);

      // Leaves
      final tipX = baseX + lean * 30 * scale + 4 * scale;
      final tipY = size.height * 0.05;

      void drawLeaf(double angle, double length) {
        final rad = angle * math.pi / 180;
        final endX = tipX + math.cos(rad) * length * scale;
        final endY = tipY + math.sin(rad) * length * scale;
        final midX = tipX + math.cos(rad) * length * 0.5 * scale + math.cos(rad + math.pi / 3) * 20 * scale;
        final midY = tipY + math.sin(rad) * length * 0.5 * scale + math.sin(rad + math.pi / 3) * 20 * scale;
        final lp = Path();
        lp.moveTo(tipX, tipY);
        lp.quadraticBezierTo(midX, midY, endX, endY);
        lp.quadraticBezierTo(midX + 4 * scale, midY + 4 * scale, tipX + 3 * scale, tipY + 3 * scale);
        lp.close();
        canvas.drawPath(lp, paint);
      }

      drawLeaf(-80, 70);
      drawLeaf(-60, 75);
      drawLeaf(-30, 65);
      drawLeaf(0, 55);
      drawLeaf(20, 50);
      drawLeaf(-100, 60);
      drawLeaf(-130, 55);
    }

    drawPalm(30, 1.0, 0.4);
    drawPalm(size.width - 50, 1.1, -0.5);
    drawPalm(size.width * 0.15, 0.7, 0.2);
    drawPalm(size.width * 0.88, 0.75, -0.3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
