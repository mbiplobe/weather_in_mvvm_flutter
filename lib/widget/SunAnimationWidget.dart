import 'package:flutter/material.dart';
import 'dart:math';

import 'SunPainter.dart';

class SunAnimationWidget extends StatefulWidget {
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime currentTime;

  const SunAnimationWidget({
    super.key,
    required this.sunrise,
    required this.sunset,
    required this.currentTime,
  });

  @override
  State<SunAnimationWidget> createState() => _SunAnimationWidgetState();
}

class _SunAnimationWidgetState extends State<SunAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double sunProgress; // from 0.0 (sunrise) to 1.0 (sunset)

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _controller.forward();

    sunProgress = _calculateSunProgress(
      widget.sunrise,
      widget.sunset,
      widget.currentTime,
    );
  }

  double _calculateSunProgress(DateTime sunrise, DateTime sunset, DateTime now) {
    if (now.isBefore(sunrise)) return 0.0;
    if (now.isAfter(sunset)) return 1.0;
    final total = sunset.difference(sunrise).inMinutes;
    final elapsed = now.difference(sunrise).inMinutes;
    return elapsed / total;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: CustomPaint(
            size: const Size(double.infinity, 200),
            painter: SunPainter(progress: sunProgress * _controller.value),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
