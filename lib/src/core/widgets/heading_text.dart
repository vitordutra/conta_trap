import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String data;
  const HeadingText(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Text(
        data,
        style: const TextStyle(
            fontFamily: 'Montserrat', letterSpacing: .5, fontSize: 24),
      ),
    );
  }
}
