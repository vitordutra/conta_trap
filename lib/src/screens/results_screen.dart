import 'package:conta_trap/src/widgets/curved_header.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      CurvedHeader(),
      Text(
        "Histórico",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24),
      ),
      Card(
        child: null,
      )
    ]));
  }
}
