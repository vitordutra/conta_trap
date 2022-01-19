import 'dart:math';

enum ActionType { PAY_LESS, PAY_MORE, PAY_NOTHING, SWITCH_WHO_PAY_LESS }

class Action {
  final ActionType type;

  double doubleValue = 0;
  int intValue = 0;
  bool boolValue = false;

  Action({required this.type});

  void setValues(
      {required double doubleValue,
      required int intValue,
      required bool boolValue}) {
    this.doubleValue = doubleValue;
    this.intValue = intValue;
    this.boolValue = boolValue;
  }

  String getText() {
    switch (type) {
      case ActionType.PAY_LESS:
        return "Você pagará $intValue% a menos";
      case ActionType.PAY_MORE:
        return "Você pagará $intValue% a mais";
      case ActionType.SWITCH_WHO_PAY_LESS:
        return "Sua parte da conta será trocada por quem atualmente pagará menos";
      default:
        return "Sua conta será zerada e sua parte dividida entre os demais jogadores";
    }
  }
}
