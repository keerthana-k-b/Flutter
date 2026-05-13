import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OrderTrackingMockPage(orderId: "demo123"),
    ),
  );
}

class OrderTrackingMockPage extends StatelessWidget {
  final String orderId;
  const OrderTrackingMockPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(size: Size.infinite, painter: RealisticFakeMapPainter()),

          // Close button
          Positioned(
            top: 52, left: 16,
            child: _circleButton(Icons.close),
          ),

          // Help + location buttons
          Positioned(
            top: 52, right: 16,
            child: Column(children: [
              _circleButton(Icons.help_outline),
              const SizedBox(height: 10),
              _circleButton(Icons.my_location),
            ]),
          ),

          // Bottom card
          Positioned(
            bottom: 24, left: 16, right: 16,
            child: _bottomCard(),
          ),
        ],
      ),
    );
  }

  static Widget _circleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, size: 22, color: Colors.black87),
    );
  }

  static Widget _bottomCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2ECC71), Color(0xFF1E9E52)],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Preparing your order",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
              Icon(Icons.access_time_rounded, color: Colors.white70, size: 18),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            "Arrives between 11:23 PM – 12:01 AM",
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 18),
          _progressRow(),
          const SizedBox(height: 14),
          const Text(
            "Joyful is preparing your order.",
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 14),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "View all details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down_rounded,
                      color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _progressRow() {
    return Row(
      children: [
        _stepIcon(Icons.store_rounded, active: true),
        _progressLine(active: true),
        _stepIcon(Icons.delivery_dining_rounded, active: true, isCurrent: true),
        _progressLine(active: false),
        _stepIcon(Icons.home_rounded, active: false),
      ],
    );
  }

  static Widget _stepIcon(IconData icon,
      {required bool active, bool isCurrent = false}) {
    return Container(
      width: isCurrent ? 42 : 38,
      height: isCurrent ? 42 : 38,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white.withOpacity(0.25),
        shape: BoxShape.circle,
        border: isCurrent
            ? Border.all(color: Colors.white.withOpacity(0.6), width: 2.5)
            : null,
      ),
      child: Icon(
        icon,
        size: isCurrent ? 22 : 20,
        color: active ? const Color(0xFF27AE60) : Colors.white,
      ),
    );
  }

  static Widget _progressLine({required bool active}) {
    return Expanded(
      child: Container(
        height: 3,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class RealisticFakeMapPainter extends CustomPainter {
  // Grid config
  static const double _majorRoadW = 14.0;
  static const double _minorRoadW = 7.0;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ── 1. BACKGROUND ────────────────────────────────────────────────────────
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFFE8E0D5),
    );

    // ── 2. COMPUTE GRID LINES ────────────────────────────────────────────────
    // 6 vertical major roads, evenly spaced
    final int vCount = 6;
    final double vStep = w / vCount;
    final List<double> vRoads =
        List.generate(vCount + 1, (i) => i * vStep);

    // 7 horizontal major roads
    final int hCount = 6;
    final double hStep = h / hCount;
    final List<double> hRoads =
        List.generate(hCount + 1, (i) => i * hStep);

    // ── 3. FILL CITY BLOCKS ──────────────────────────────────────────────────
    // Every cell between two adjacent major roads is a city block
    final List<Color> blockPalette = const [
      Color(0xFFDDD8CE),
      Color(0xFFD8D4CA),
      Color(0xFFD4D0C6),
      Color(0xFFDAD5CB),
    ];
    // Special cells: parks (green) and water (blue)
    // park at col 2, row 1 and col 4, row 3
    // water at row 2 (full row)
    const int parkCol1 = 2, parkRow1 = 1;
    const int parkCol2 = 4, parkRow2 = 3;
    const int waterRow = 2;

    final rng = Random(7);

    for (int row = 0; row < hCount; row++) {
      for (int col = 0; col < vCount; col++) {
        final x1 = vRoads[col] + _majorRoadW / 2;
        final y1 = hRoads[row] + _majorRoadW / 2;
        final x2 = vRoads[col + 1] - _majorRoadW / 2;
        final y2 = hRoads[row + 1] - _majorRoadW / 2;
        final rect = Rect.fromLTRB(x1, y1, x2, y2);

        Color fill;
        if (row == waterRow) {
          fill = const Color(0xFFB8D4E8);
        } else if ((row == parkRow1 && col == parkCol1) ||
            (row == parkRow2 && col == parkCol2)) {
          fill = const Color(0xFFC5D9A8);
        } else {
          fill = blockPalette[rng.nextInt(blockPalette.length)];
        }

        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(3)),
          Paint()..color = fill,
        );

        // Park trees
        if ((row == parkRow1 && col == parkCol1) ||
            (row == parkRow2 && col == parkCol2)) {
          _drawParkTrees(canvas, rect);
        }

        // Water ripples
        if (row == waterRow) {
          _drawWaterRipples(canvas, rect);
        }
      }
    }

    // ── 4. MINOR ROADS (halfway between major roads) ─────────────────────────
    final minorPaint = Paint()
      ..color = const Color(0xFFEFEBE5)
      ..strokeWidth = _minorRoadW
      ..strokeCap = StrokeCap.butt;

    // horizontal minor roads
    for (int row = 0; row < hCount; row++) {
      final y = (hRoads[row] + hRoads[row + 1]) / 2;
      canvas.drawLine(Offset(0, y), Offset(w, y), minorPaint);
    }

    // vertical minor roads
    for (int col = 0; col < vCount; col++) {
      final x = (vRoads[col] + vRoads[col + 1]) / 2;
      canvas.drawLine(Offset(x, 0), Offset(x, h), minorPaint);
    }

    // ── 5. MAJOR ROADS (shadow + surface) ────────────────────────────────────
    final roadShadow = Paint()
      ..color = Colors.black.withOpacity(0.06)
      ..strokeWidth = _majorRoadW + 6
      ..strokeCap = StrokeCap.butt;

    final roadSurface = Paint()
      ..color = const Color(0xFFF5F2EE)
      ..strokeWidth = _majorRoadW
      ..strokeCap = StrokeCap.butt;

    // Draw horizontal major roads
    for (final y in hRoads) {
      canvas.drawLine(Offset(0, y), Offset(w, y), roadShadow);
      canvas.drawLine(Offset(0, y), Offset(w, y), roadSurface);
    }

    // Draw vertical major roads
    for (final x in vRoads) {
      canvas.drawLine(Offset(x, 0), Offset(x, h), roadShadow);
      canvas.drawLine(Offset(x, 0), Offset(x, h), roadSurface);
    }

    // ── 6. CENTER DASHES ─────────────────────────────────────────────────────
    final dashPaint = Paint()
      ..color = const Color(0xFFD8D3C8)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (final y in hRoads) {
      _drawDashed(canvas, Offset(0, y), Offset(w, y), dashPaint, 10, 8);
    }
    for (final x in vRoads) {
      _drawDashed(canvas, Offset(x, 0), Offset(x, h), dashPaint, 10, 8);
    }

    // ── 7. STREET LABELS ─────────────────────────────────────────────────────
    final streetNames = ['Main St', 'Oak Ave', 'Cedar Blvd', 'Park Rd', '5th St'];
    for (int i = 0; i < streetNames.length; i++) {
      _drawLabel(
          canvas, streetNames[i], Offset(8, hRoads[i + 1] - 3));
    }

    final avNames = ['1st Ave', '2nd Ave', '3rd Ave', '4th Ave', '5th Ave'];
    for (int i = 0; i < avNames.length; i++) {
      _drawLabel(
          canvas, avNames[i], Offset(vRoads[i + 1] + 4, 12));
    }

    // ── 8. DELIVERY ROUTE ────────────────────────────────────────────────────
    // Route: follows roads exactly
    // Store at vRoads[1] × hRoads[1]
    // Turn at vRoads[3] × hRoads[1]
    // Rider at vRoads[3] × hRoads[3]
    // Turn at vRoads[3] × hRoads[5]
    // Home at vRoads[5] × hRoads[5]

    final storePos = Offset(vRoads[1], hRoads[1]);
    final turn1    = Offset(vRoads[3], hRoads[1]);
    final riderPos = Offset(vRoads[3], hRoads[3]);
    final turn2    = Offset(vRoads[3], hRoads[5]);
    final homePos  = Offset(vRoads[5], hRoads[5]);

    final routePoints = [storePos, turn1, riderPos, turn2, homePos];
    final routePath = Path()..moveTo(storePos.dx, storePos.dy);
    for (int i = 1; i < routePoints.length; i++) {
      routePath.lineTo(routePoints[i].dx, routePoints[i].dy);
    }

    // Glow
    canvas.drawPath(
      routePath,
      Paint()
        ..color = Colors.orange.withOpacity(0.20)
        ..strokeWidth = 20
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Dashed route line
    _drawDashedPath(canvas, routePoints,
        Paint()
          ..color = const Color(0xFFFF9500)
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke,
        14, 9);

    // ── 9. INTERSECTION DOTS ─────────────────────────────────────────────────
    for (final pt in [turn1, turn2]) {
      canvas.drawCircle(
          pt, 5, Paint()..color = Colors.orange.withOpacity(0.6));
    }

    // ── 10. MARKERS ──────────────────────────────────────────────────────────
    _drawStoreMarker(canvas, storePos);
    _drawPulse(canvas, riderPos, const Color(0xFF3498DB));
    _drawRiderMarker(canvas, riderPos);
    _drawHomeMarker(canvas, homePos);
  }

  // ── HELPERS ────────────────────────────────────────────────────────────────

  void _drawParkTrees(Canvas canvas, Rect block) {
    final p = Paint()..color = const Color(0xFF9ABD70);
    final centers = [
      Offset(block.left + block.width * 0.25, block.top + block.height * 0.3),
      Offset(block.left + block.width * 0.55, block.top + block.height * 0.5),
      Offset(block.left + block.width * 0.75, block.top + block.height * 0.25),
      Offset(block.left + block.width * 0.35, block.top + block.height * 0.70),
    ];
    final radii = [7.0, 9.0, 6.0, 8.0];
    for (int i = 0; i < centers.length; i++) {
      canvas.drawCircle(centers[i], radii[i], p);
    }
  }

  void _drawWaterRipples(Canvas canvas, Rect block) {
    final p = Paint()
      ..color = const Color(0xFFA8C4D8)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 3; i++) {
      final y = block.top + block.height * (0.25 + i * 0.25);
      final path = Path()
        ..moveTo(block.left + 8, y)
        ..quadraticBezierTo(
          block.left + block.width * 0.35, y - 5,
          block.left + block.width * 0.65, y,
        )
        ..quadraticBezierTo(
          block.left + block.width * 0.85, y + 5,
          block.right - 8, y,
        );
      canvas.drawPath(path, p);
    }
  }

  void _drawDashed(Canvas canvas, Offset start, Offset end, Paint paint,
      double dashLen, double gapLen) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final len = sqrt(dx * dx + dy * dy);
    final nx = dx / len;
    final ny = dy / len;
    double t = 0;
    bool drawing = true;
    while (t < len) {
      final seg = (drawing ? dashLen : gapLen).clamp(0.0, len - t);
      if (drawing) {
        canvas.drawLine(
          Offset(start.dx + nx * t, start.dy + ny * t),
          Offset(start.dx + nx * (t + seg), start.dy + ny * (t + seg)),
          paint,
        );
      }
      t += seg;
      drawing = !drawing;
    }
  }

  void _drawDashedPath(Canvas canvas, List<Offset> points, Paint paint,
      double dashLen, double gapLen) {
    double remaining = 0;
    bool drawing = true;
    for (int i = 0; i < points.length - 1; i++) {
      Offset a = points[i];
      final b = points[i + 1];
      final dx = b.dx - a.dx;
      final dy = b.dy - a.dy;
      final segLen = sqrt(dx * dx + dy * dy);
      final nx = dx / segLen;
      final ny = dy / segLen;
      double t = 0;
      if (remaining > 0) {
        final draw = min(remaining, segLen);
        if (drawing) {
          canvas.drawLine(a, Offset(a.dx + nx * draw, a.dy + ny * draw), paint);
        }
        t = draw;
        remaining -= draw;
        if (remaining <= 0) {
          drawing = !drawing;
          remaining = drawing ? dashLen : gapLen;
        }
      } else {
        remaining = drawing ? dashLen : gapLen;
      }
      while (t < segLen) {
        final draw = min(remaining, segLen - t);
        if (drawing) {
          canvas.drawLine(
            Offset(a.dx + nx * t, a.dy + ny * t),
            Offset(a.dx + nx * (t + draw), a.dy + ny * (t + draw)),
            paint,
          );
        }
        t += draw;
        remaining -= draw;
        if (remaining <= 0) {
          drawing = !drawing;
          remaining = drawing ? dashLen : gapLen;
        }
      }
    }
  }

  void _drawLabel(Canvas canvas, String text, Offset pos) {
    TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFFB0A898),
          fontSize: 9,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    )
      ..layout()
      ..paint(canvas, pos);
  }

  void _drawPulse(Canvas canvas, Offset pos, Color color) {
    canvas.drawCircle(pos, 28, Paint()..color = color.withOpacity(0.10));
    canvas.drawCircle(pos, 20, Paint()..color = color.withOpacity(0.18));
  }

  void _drawStoreMarker(Canvas canvas, Offset pos) {
    canvas.drawCircle(pos, 18, Paint()..color = Colors.white);
    canvas.drawCircle(pos, 13, Paint()..color = const Color(0xFF2ECC71));
    // roof
    final roof = Path()
      ..moveTo(pos.dx, pos.dy - 10)
      ..lineTo(pos.dx - 8, pos.dy - 3)
      ..lineTo(pos.dx + 8, pos.dy - 3)
      ..close();
    canvas.drawPath(roof, Paint()..color = Colors.white);
    // body
    canvas.drawRect(
      Rect.fromCenter(center: pos.translate(0, 4), width: 13, height: 9),
      Paint()..color = Colors.white,
    );
    // door
    canvas.drawRect(
      Rect.fromCenter(center: pos.translate(0, 7), width: 4, height: 5),
      Paint()..color = const Color(0xFF2ECC71),
    );
  }

  void _drawRiderMarker(Canvas canvas, Offset pos) {
    canvas.drawCircle(pos, 18, Paint()..color = Colors.white);
    canvas.drawCircle(pos, 13, Paint()..color = const Color(0xFF3498DB));
    // head
    canvas.drawCircle(
        pos.translate(0, -5), 4, Paint()..color = Colors.white);
    // body arc
    final body = Path()
      ..moveTo(pos.dx - 7, pos.dy + 3)
      ..quadraticBezierTo(pos.dx, pos.dy - 1, pos.dx + 7, pos.dy + 3);
    canvas.drawPath(
      body,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawHomeMarker(Canvas canvas, Offset pos) {
    canvas.drawCircle(pos, 18, Paint()..color = Colors.white);
    canvas.drawCircle(pos, 13, Paint()..color = const Color(0xFFE74C3C));
    // roof
    final roof = Path()
      ..moveTo(pos.dx, pos.dy - 10)
      ..lineTo(pos.dx - 8, pos.dy - 2)
      ..lineTo(pos.dx + 8, pos.dy - 2)
      ..close();
    canvas.drawPath(roof, Paint()..color = Colors.white);
    // walls
    canvas.drawRect(
      Rect.fromLTWH(pos.dx - 6, pos.dy - 2, 12, 9),
      Paint()..color = Colors.white,
    );
    // door
    canvas.drawRect(
      Rect.fromLTWH(pos.dx - 2.5, pos.dy + 1, 5, 6),
      Paint()..color = const Color(0xFFE74C3C),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/presentation/screens/splash_screen.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     ),
//   );
// }

// class OrderTrackingMockPage extends StatelessWidget {
//   final String orderId;

//   const OrderTrackingMockPage({super.key, required this.orderId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           /// FAKE MAP BACKGROUND
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//              gradient: LinearGradient(
//               colors: [Color(0xFFF5F5F5), Color(0xFFEDEDED)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//              ),
//             ),
//             // color: Colors.grey.shade200,
//             child: CustomPaint(
//               painter: FakeMapPainter(),
//             ),
//           ),

//           /// TOP LEFT CLOSE BUTTON
//           Positioned(
//             top: 50,
//             left: 16,
//             child: _circleButton(Icons.close),
//           ),

//           /// TOP RIGHT BUTTONS
//           Positioned(
//             top: 50,
//             right: 16,
//             child: Column(
//               children: [
//                 _circleButton(Icons.help_outline),
//                 const SizedBox(height: 10),
//                 _circleButton(Icons.my_location),
//               ],
//             ),
//           ),

//           /// BOTTOM CARD
//           Positioned(
//             bottom: 20,
//             left: 16,
//             right: 16,
//             child: _buildBottomCard(),
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget _circleButton(IconData icon) {
//     return Container(
//       padding:  EdgeInsets.all(12),
//       decoration:  BoxDecoration(
//         color: Colors.white.withOpacity(0.9),
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           )
//         ]
//       ),
//       child: Icon(icon, size: 22),
//     );
//   }

//   static Widget _buildBottomCard() {
//     return Container(
//       padding:  EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
        
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//           color: Colors.black.withOpacity(0.15),
//           blurRadius: 20,
//           offset: Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//            Text(
//             "Preparing your order",
//             style: TextStyle(color: Colors.white, fontSize: 18),
//           ),
//            SizedBox(height: 8),
//            Text(
//             "Arrives between 11:23 PM - 12:01 AM",
//             style: TextStyle(color: Colors.white70),
//           ),
//            SizedBox(height: 12),
//           Row(
//             children: [
//               Icon(Icons.store, color: Colors.white),
//               Expanded(child: Divider(color: Colors.white)),
//               Icon(Icons.delivery_dining, color: Colors.white),
//               Expanded(child: Divider(color: Colors.white)),
//               Icon(Icons.home, color: Colors.white),
//             ],
//           ),
//            SizedBox(height: 10),
//            Text(
//             "Your order is being prepared.",
//             style: TextStyle(color: Colors.white70),
//           ),
//            SizedBox(height: 10),
//            Center(
//             child: Text(
//               "View all details",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FakeMapPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {

//     /// BACKGROUND
//     final bg = Paint()..color = const Color(0xFFF3F3F3);
//     canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

//     /// ROAD STYLES
//     final mainRoad = Paint()
//       ..color = Colors.white
//       ..strokeWidth = 14
//       ..strokeCap = StrokeCap.round;

//     final subRoad = Paint()
//       ..color = Colors.white.withOpacity(0.95)
//       ..strokeWidth = 8
//       ..strokeCap = StrokeCap.round;

//     final smallRoad = Paint()
//       ..color = Colors.white.withOpacity(0.7)
//       ..strokeWidth = 4
//       ..strokeCap = StrokeCap.round;

//     /// =========================
//     /// 🏙️ CITY GRID (KEY PART)
//     /// =========================

//     int rows = 8;
//     int cols = 6;

//     double rowHeight = size.height / rows;
//     double colWidth = size.width / cols;

//     /// horizontal roads
//     for (int i = 1; i < rows; i++) {
//       final y = i * rowHeight;

//       final path = Path()
//         ..moveTo(0, y)
//         ..quadraticBezierTo(
//           size.width * 0.5,
//           y + (i % 2 == 0 ? -20 : 20),
//           size.width,
//           y,
//         );

//       canvas.drawPath(path, i % 2 == 0 ? mainRoad : subRoad);
//     }

//     /// vertical roads
//     for (int j = 1; j < cols; j++) {
//       final x = j * colWidth;

//       final path = Path()
//         ..moveTo(x, 0)
//         ..quadraticBezierTo(
//           x + (j % 2 == 0 ? 20 : -20),
//           size.height * 0.5,
//           x,
//           size.height,
//         );

//       canvas.drawPath(path, j % 2 == 0 ? mainRoad : subRoad);
//     }

//     /// =========================
//     /// 🧩 SMALL INNER STREETS
//     /// =========================
//     for (int i = 0; i < 12; i++) {
//       double startX = (i % cols) * colWidth + 20;
//       double startY = (i ~/ cols) * rowHeight + 20;

//       final path = Path()
//         ..moveTo(startX, startY)
//         ..quadraticBezierTo(
//           startX + 40,
//           startY + 60,
//           startX + 80,
//           startY + 100,
//         );

//       canvas.drawPath(path, smallRoad);
//     }

//     /// =========================
//     /// 🚚 DELIVERY ROUTE
//     /// =========================
//     final route = Path()
//       ..moveTo(40, size.height * 0.4)
//       ..cubicTo(
//         size.width * 0.3,
//         size.height * 0.2,
//         size.width * 0.6,
//         size.height * 0.7,
//         size.width - 40,
//         size.height * 0.6,
//       );

//     /// glow
//     canvas.drawPath(
//       route,
//       Paint()
//         ..color = Colors.orange.withOpacity(0.25)
//         ..strokeWidth = 12
//         ..style = PaintingStyle.stroke,
//     );

//     /// main line
//     canvas.drawPath(
//       route,
//       Paint()
//         ..color = Colors.orange
//         ..strokeWidth = 5
//         ..style = PaintingStyle.stroke,
//     );

//     /// =========================
//     /// 📍 MARKERS
//     /// =========================
//     void marker(Offset pos, Color color) {
//       canvas.drawCircle(pos, 10, Paint()..color = Colors.white);
//       canvas.drawCircle(pos, 6, Paint()..color = color);
//     }

//     marker(Offset(40, size.height * 0.4), Colors.green);
//     marker(Offset(size.width * 0.5, size.height * 0.5), Colors.blue);
//     marker(Offset(size.width - 40, size.height * 0.6), Colors.red);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }