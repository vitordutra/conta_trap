import 'package:conta_trap/src/core/widgets/action_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF7F55F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.75,
                child: Center(
                  child: Image.asset("assets/images/conta_trap_icon.png",
                      width: screenWidth * 0.25),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    "Iniciar",
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF7F55F5),
                    onPressed: () {
                      Navigator.pushNamed(context, "/begin");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    "Histórico",
                    backgroundColor: const Color(0xFF7F55F5),
                    foregroundColor: Colors.white,
                    borderColor: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, "/history");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
