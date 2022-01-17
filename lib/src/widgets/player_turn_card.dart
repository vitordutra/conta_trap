import 'package:flutter/material.dart';

class PlayerTurnCard extends StatelessWidget {
  final String text;
  final String caption;

  const PlayerTurnCard({required this.text, required this.caption, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(16),),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Expanded(
              child: Center(
                  child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),
          ),)),
          Text(
            caption,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withOpacity(0.67),
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
