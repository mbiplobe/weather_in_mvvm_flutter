import 'dart:math';

import 'package:flutter/material.dart';

class OneDirectionLine extends StatelessWidget {
  const OneDirectionLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomPaint(
        // Width × Height of the canvas
        painter: ArrowLinePainter(),
      ),
    );
  }
}

class ArrowLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final start = Offset(20, size.height / 2);
    final end = Offset(size.width - 20, size.height / 2);

    // Draw main line
    canvas.drawLine(start, end, paint);

    // Arrowhead
    const arrowLength = 12.0;
    final angle = atan2(end.dy - start.dy, end.dx - start.dx);

    final path = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(end.dx - arrowLength * cos(angle - pi / 6),
          end.dy - arrowLength * sin(angle - pi / 6))
      ..moveTo(end.dx, end.dy)
      ..lineTo(end.dx - arrowLength * cos(angle + pi / 6),
          end.dy - arrowLength * sin(angle + pi / 6));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}