
import 'package:flutter/cupertino.dart';

class CustomVerticalText extends StatelessWidget {
  final String titleText;
  final String valueText;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const CustomVerticalText({super.key, required this.titleText, required this.valueText, required this.fontSize, required this.color, required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Text(
      valueText,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
      ),
        Text(
            titleText,
            style: TextStyle(
              fontSize: fontSize,
              color: color,
              fontWeight: FontWeight.bold,
            ),
        ),
      ],
    );
  }
}
