import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onPressed;

  const ActionButton(
    this.text, {
    Key? key,
    this.foregroundColor = const Color(0xFFFFFFFF),
    this.backgroundColor = const Color(0xFF7F55F5),
    this.borderColor = const Color(0xFF7F55F5),
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;

    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: _screenWidth * 0.85,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(color: foregroundColor, letterSpacing: .5),
            ),
          ),
        ),
      ),
    );
  }
}
