import 'package:conta_trap/src/classes/choice.dart';
import 'package:flutter/material.dart';

class ChoiceCard extends StatelessWidget {
  final Choice choice;

  const ChoiceCard({required this.choice, Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                choice.action.getText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: primaryColor.withOpacity(0.8),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Row(children: <Widget>[
            Expanded(
              child: Divider(
                color: primaryColor,
              ),
            ),
            Container(
              child: Text(
                "MAS",
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            Expanded(child: Divider(color: primaryColor),),
          ]),
          Expanded(
            child: Center(
              child: Text(
                choice.consequence.getText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: primaryColor.withOpacity(0.8),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
