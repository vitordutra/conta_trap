import 'package:conta_trap/src/screens/gameplay_screen.dart';
import 'package:conta_trap/src/screens/results_screen.dart';
import 'package:conta_trap/src/screens/users_input_screen.dart';
import 'package:conta_trap/src/utils/colors.dart';
import 'package:conta_trap/src/screens/bill_input_screen.dart';
import 'package:conta_trap/src/screens/history_screen.dart';
import 'package:conta_trap/src/screens/home.dart';
import 'package:flutter/material.dart';

const Color mainColor = Color(0xFF7F55F5);

class ContaTrapApp extends StatelessWidget {
  const ContaTrapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Conta Trap",
      theme: ThemeData(
        primarySwatch: generateMaterialColor(mainColor),
        fontFamily: 'Montserrat',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              width: 1.0,
              color: mainColor,
              style: BorderStyle.solid,
            ),
            padding: const EdgeInsets.all(16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/bill-input": (context) => const BillInputScreen(),
        "/users-input": (context) => UsersInputScreen(
            arguments: ModalRoute.of(context)?.settings.arguments
                as UsersInputScreenArgs),
        "/gameplay": (context) => GameplayScreen(
              arguments: ModalRoute.of(context)?.settings.arguments
                  as GameplayScreenArgs,
            ),
        "/results": (context) => ResultsScreen(
              arguments: ModalRoute.of(context)?.settings.arguments
                  as ResultsScreenArgs,
            ),
        "/history": (context) => const HistoryScreen(),
      },
    );
  }
}
