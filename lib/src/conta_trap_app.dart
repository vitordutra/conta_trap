import 'package:conta_trap/src/screens/getting_started.dart';
import 'package:flutter/material.dart';

class ContaTrapApp extends StatelessWidget {
  const ContaTrapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Conta Trap",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const GettingStarted(),
      },
    );
  }
}
