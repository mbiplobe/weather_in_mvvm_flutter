import 'dart:math';

import 'package:flutter/material.dart';

class SunPainter extends CustomPainter {
  final double progress;

  SunPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint skyPaint = Paint()
      ..shader = LinearGradient(
        colors: const [
         Colors.brown,
          Colors.brown
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), skyPaint);

    // Arc path
    final path = Path();
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2.2;

    final Paint arcPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // start at 180 degrees
      pi, // sweep 180 degrees
      false,
      arcPaint,
    );

    // Sun position along the arc
    final sunAngle = pi + (progress * pi);
    final sunX = center.dx + radius * cos(sunAngle);
    final sunY = center.dy + radius * sin(sunAngle);

    final sunPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(sunX, sunY), 16, sunPaint);
  }

  @override
  bool shouldRepaint(covariant SunPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
