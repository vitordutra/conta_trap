import 'package:conta_trap/src/core/widgets/action_button.dart';
import 'package:conta_trap/src/core/widgets/heading_text.dart';
import 'package:conta_trap/src/screens/gameplay_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class UsersInputScreenArgs {
  final double bill;

  const UsersInputScreenArgs({required this.bill});
}

class UsersInputScreen extends StatefulWidget {
  final UsersInputScreenArgs arguments;

  const UsersInputScreen({required this.arguments, Key? key}) : super(key: key);

  @override
  _UsersInputScreenState createState() => _UsersInputScreenState();
}

class _UsersInputScreenState extends State<UsersInputScreen> {
  final _controller = TextEditingController();
  final List<String> players = [];

  // States
  bool _isDirty = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleProceed() {
    bool isPlayersEmpty = players.isEmpty;

    requestAddPlayer();

    if (isPlayersEmpty) {
      setState(() {});
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/gameplay',
      ModalRoute.withName('/'),
      arguments: GameplayScreenArgs(
        bill: widget.arguments.bill,
        players: players,
      ),
    );
  }

  bool canPlayerBeAdded() {
    String playerName = _controller.text;

    if (playerName.isEmpty || playerName.length <= 3) {
      setState(() => _isDirty = true);
      return false;
    }

    return true;
  }

  void requestAddPlayer() {
    if (canPlayerBeAdded()) {
      String playerName = _controller.text;
      players.add(playerName);
      _controller.clear();

      setState(() {});
    }
  }

  Future<bool> onBackPress() {
    if (players.isEmpty) {
      Navigator.pop(context);
      return Future.value(true);
    }

    players.removeLast();
    setState(() {});

    return Future.value(false);
  }

  String getIndexText() {
    int playersLength = players.length;

    if (playersLength == 0) {
      return "primeiro";
    } else if (playersLength == 1) {
      return "segundo";
    } else if (playersLength == 2) {
      return "terceiro";
    } else if (playersLength == 3) {
      return "quarto";
    } else if (playersLength == 4) {
      return "quinto";
    } else if (playersLength == 5) {
      return "sexto";
    } else if (playersLength == 6) {
      return "sétimo";
    } else if (playersLength == 7) {
      return "oitavo";
    } else if (playersLength == 8) {
      return "nono";
    } else if (playersLength == 9) {
      return "décimo";
    } else {
      return "$playersLength°";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black54,
            ),
            onPressed: onBackPress,
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HeadingText(text: "Quem é o ${getIndexText()} pagante?"),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      errorText: _isDirty
                          ? "Este campo é obrigatório (mínimo de 3 caracteres)"
                          : null,
                      errorMaxLines: 3,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (players.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: OutlinedButton(
                          onPressed: requestAddPlayer,
                          child: const Text("ADICIONAR MAIS PAGANTES"),
                        ),
                      ),
                    ElevatedButton(
                      onPressed: handleProceed,
                      child: Text(players.isEmpty ? "AVANÇAR" : "INICIAR"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
