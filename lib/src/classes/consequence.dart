import 'dart:math';

import 'package:conta_trap/src/classes/action.dart';

class Consequence {
  final int id;
  final int malice;

  final bool isTargetRequired;
  final bool isEffectBeforeAction;

  late Action action;

  late String targetName;
  late int targetIndex;

  int intValue = 0;
  double doubleValue = 0;
  bool boolValue = false;

  Consequence({
    required this.malice,
    required this.id,
    this.isTargetRequired = false,
    this.isEffectBeforeAction = true,
  });

  // Consequence clone() {
  //   return Consequence(
  //     id: id,
  //     malice: malice,
  //     isTargetRequired: isTargetRequired,
  //     isEffectBeforeAction: isEffectBeforeAction,
  //   )
  //     ..action = action
  //     ..boolValue = boolValue
  //     ..intValue = intValue
  //     ..doubleValue = doubleValue
  //     ..targetIndex = targetIndex
  //     ..targetName = targetName;
  // }

  void setAction(Action action) {
    this.action = action;
    _configureConsequence();
  }

  void _configureConsequence() {
    doubleValue = action.doubleValue;
    boolValue = action.boolValue;
    intValue = action.intValue;
  }

  static Consequence getRandomConsequence() {
    final List<Consequence> consequences = [
      Consequence(id: 0, malice: 0),
      Consequence(id: 1, malice: 3, isTargetRequired: true),
      Consequence(id: 2, malice: 1),
      Consequence(id: 3, malice: 2),
      Consequence(id: 4, malice: 4),
      Consequence(id: 5, malice: 4, isEffectBeforeAction: true),
      Consequence(id: 6, malice: 6, isEffectBeforeAction: true),
      Consequence(id: 7, malice: 0)
    ];

    int r = Random().nextInt(consequences.length);

    return consequences[r];
  }

  String getText() {
    switch (id) {
      case 0:
        return "O demais jogadores paragão a mais";
      case 1:
        return "$targetName pagará a mais";
      case 2:
        return "Um jogador aleatório pagará a mais";
      case 3:
        return "Você perderá sua próxima jogada";
      case 4:
        return "Você perderá todas suas próximas jogadas";
      case 5:
        return "Existe $intValue% de chance do efeito da sua ação ser invertido";
      case 6:
        return "Se o próximo jogador ${boolValue ? 'aceitar' : 'recusar'} sua condição, o efeito da sua ação será invertido";
      default:
        return "O próximo jogador paguará menos e você pagará a mais";
    }
  }
}
