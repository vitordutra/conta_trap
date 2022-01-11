import 'package:conta_trap/src/core/widgets/action_button.dart';
import 'package:conta_trap/src/core/widgets/heading_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BeginScreen extends StatelessWidget {
  const BeginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadingText("Qual o valor da conta de Hoje?"),
              SizedBox(
                height: screenHeight * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "249.50",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF7F55F5),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    "Voltar",
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF7F55F5),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    "Avançar",
                    backgroundColor: const Color(0xFF7F55F5),
                    foregroundColor: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/history");
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
