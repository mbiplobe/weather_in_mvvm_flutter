

import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          time,
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 8),
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 8),
        Text(
          temp,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}