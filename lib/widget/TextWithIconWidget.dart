
import 'package:flutter/material.dart';

class TextWithIconWidget extends StatelessWidget {

  final String text;
  final Image source;

  const TextWithIconWidget({super.key, required this.text, required this.source});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        source,
        SizedBox(width: 8,),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),

      ],
    );
  }
}
