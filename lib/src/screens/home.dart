import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: const Color(0xFF7F55F5),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset("assets/images/conta_trap_icon.png",
                      width: screenWidth * 0.25),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, "/bill-input"),
                      child: Text(
                        "INICIAR",
                        style: TextStyle(color: primaryColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: primaryColor,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.pushNamed(context, "/history"),
                    child: const Text("HISTÓRICO",
                        style: TextStyle(color: Colors.white)),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      side: const BorderSide(
                        width: 1.0,
                        color: Colors.white,
                        style: BorderStyle.solid,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
