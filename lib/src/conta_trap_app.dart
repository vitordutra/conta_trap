import 'package:conta_trap/src/screens/getting_started.dart';
import 'package:conta_trap/src/screens/choice_screen.dart';
import 'package:conta_trap/src/screens/results_screen.dart';
import 'package:conta_trap/src/utils/colors.dart';
import 'package:flutter/material.dart';

class ContaTrapApp extends StatelessWidget {
  const ContaTrapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Conta Trap",
      theme: ThemeData(
          primarySwatch: generateMaterialColor(const Color(0xFF7F55F5)),
          fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      initialRoute: "/choice",
      routes: {
        "/": (context) => const GettingStarted(),
        "/choice": (context) => ChoiceScreen(
            arguments: ChoiceScreenArgs()
              ..billAmount = 140
              ..players = ["Alexandre", "João Vitor", "Rafael"]),
        // ModalRoute.of(context)?.settings.arguments as ChoiceScreenArgs),
        "/results": (context) => const ResultsScreen(),
      },
    );
  }
}
