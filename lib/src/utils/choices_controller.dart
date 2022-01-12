import 'dart:math';
import 'package:conta_trap/src/classes/choice.dart';



class ChoicesController {
  List<String> players;
  double billAmount;

  int currentPlayerIndex = 0;
  
  late Choice currentChoice;
  late List<double> playerCharges;

  ChoicesController({required this.players, required this.billAmount}) {
    double charge = billAmount / players.length;
    playerCharges = players.map((_) => charge).toList();

    createChoice();
  }

  void createChoice() {
    currentChoice = Choice(action: "Ação", consequence: "Consequência");
  }

  void next() {
    _nextPlayer();
  }

  Choice getCurrentChoice() {
    return currentChoice;
  }

  String getCurrentPlayer() {
    return players[currentPlayerIndex];
  }

  // Choice(
  //                                       action: "Você pagará 20% a menos",
  //                                       consequence:
  //                                           "Alexandre pagará 10% a mais")

  void _nextPlayer() {
    if (currentPlayerIndex == players.length - 1) {
      currentPlayerIndex = 0;
    } else {
      currentPlayerIndex++;
    }
  }

  double getChargeOfPlayer(String player) {
    int idx = players.indexOf(player);

    if (idx > -1) {
      return playerCharges[idx];
    }

    throw Exception("Player doesn't exists.");
  }
}
