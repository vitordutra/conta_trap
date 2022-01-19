import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String text;

  const HeadingText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Text(
        text,
        style: const TextStyle(
          letterSpacing: 1.5,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
