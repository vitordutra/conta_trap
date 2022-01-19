import 'package:conta_trap/src/core/widgets/action_button.dart';
import 'package:conta_trap/src/core/widgets/heading_text.dart';
import 'package:conta_trap/src/screens/users_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class BillInputScreen extends StatefulWidget {
  const BillInputScreen({Key? key}) : super(key: key);

  @override
  _BillInputScreenState createState() => _BillInputScreenState();
}

class _BillInputScreenState extends State<BillInputScreen> {
  final _controller = MoneyMaskedTextController(leftSymbol: 'R\$ ');

  // States
  bool _isDirty = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleProceed() {
    double bill = _controller.numberValue;

    if (bill < 1) {
      setState(() => _isDirty = true);
      return;
    }

    // TODO: Verificar se bill deve ser validado
    Navigator.pushNamed(
      context,
      '/users-input',
      arguments: UsersInputScreenArgs(
        bill: bill,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // statusBarColor: Colors.red,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const HeadingText(text: "Qual o valor da conta de Hoje?"),
              Expanded(
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorText: _isDirty
                        ? "Você seriamente pretende rachar uma conta desse valor? Rache ao menos R\$ 1,00"
                        : null,
                    errorMaxLines: 3,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: handleProceed,
                child: const Text("AVANÇAR"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
