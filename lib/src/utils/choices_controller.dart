import 'dart:math';
import 'package:conta_trap/src/classes/action.dart';
import 'package:conta_trap/src/classes/choice.dart';
import 'package:conta_trap/src/classes/consequence.dart';

Consequence _getRandomConsequence(int rerollsForWrose,
    [int maliceMultiplier = 1, int lastMalice = -1]) {
  Consequence consequence = Consequence.getRandomConsequence();

  int malice = maliceMultiplier * consequence.malice;

  if (rerollsForWrose > 0) {
    Consequence rerollConsequence = _getRandomConsequence(
        rerollsForWrose - 1, maliceMultiplier, consequence.malice);
    print("Reroll malice: ${rerollConsequence.malice}");

    int rerollMalice = maliceMultiplier * rerollConsequence.malice;

    return rerollMalice > malice ? rerollConsequence : consequence;
  }

  print("Malice: ${consequence.malice}");
  return consequence;
}

ActionType getRandomActionType() {
  double r = Random().nextDouble();

  if (r < 0.05) {
    // Pagar nada (5% chance)
    return ActionType.PAY_NOTHING;
  } else if (r < 0.15) {
    // Trocar com quem paga menos (10% chance)
    return ActionType.SWITCH_WHO_PAY_LESS;
  } else if (r < 0.4) {
    // Pagar mais (25% chance)
    return ActionType.PAY_MORE;
  } else {
    // Pagar menos (60% de chance)
    return ActionType.PAY_LESS;
  }
}

class PlayerStatus {
  final String name;
  double bill;
  int rechoicesAvailable = 3;

  PlayerStatus({required this.name, this.bill = 0});

  void doRechoice() {
    if (rechoicesAvailable <= 0) {
      throw Error();
    }

    rechoicesAvailable -= 1;
  }

  bool hasRechoicesAvailable() => rechoicesAvailable > 0;
}

class MatchController {
  late List<PlayerStatus> players;
  double bill;

  int currentPlayerIndex = 0;

  List<Choice> _choices = [];

  MatchController({required List<String> players, required this.bill}) {
    double charge = bill / players.length;

    this.players = players
        .map((playerName) => PlayerStatus(name: playerName, bill: charge))
        .toList();

    createNextChoice();
  }

  Choice getCurrentChoice() {
    return _choices.last;
  }

  void createNextChoice() {
    Action action = getRandomAction();

    Consequence consequence = getRandomConsequence(action);
    _configureConsequence(action, consequence);

    Choice choice = Choice(action: action, consequence: consequence);

    _choices.add(choice);
  }

  void rechoice() {
    _choices.removeLast();
    createNextChoice();
  }

  void _configureConsequence(Action action, Consequence consequence) {
    consequence.setAction(action);

    if (consequence.isTargetRequired) {
      int r;

      do {
        r = Random().nextInt(players.length);
      } while (r != currentPlayerIndex);

      consequence.targetIndex = r;
      consequence.targetName = players[r].name;
    }
  }

  Consequence getRandomConsequence(Action action) {
    switch (action.type) {
      case ActionType.PAY_NOTHING:
        return _getRandomConsequence(4);
      case ActionType.PAY_MORE:
        return _getRandomConsequence(0, -1);
      case ActionType.PAY_LESS:
        return _getRandomConsequence(2);
      case ActionType.SWITCH_WHO_PAY_LESS:
        return _getRandomConsequence(3);
      default:
        throw UnimplementedError();
    }
  }

  Action getRandomAction() {
    // Type
    ActionType actionType = getRandomActionType();
    Action action = Action(type: actionType);

    double doubleValue = Random().nextDouble();
    bool boolValue = Random().nextBool();
    int intValue = 0;
    double maxPct = 1, minPct = 0;

    switch (actionType) {
      case ActionType.PAY_LESS:
        minPct = 0.1; // 10%
        maxPct = 0.5; // 50%
        break;
      case ActionType.PAY_MORE:
        minPct = 0.1; // 10%
        maxPct = 0.4; // 40%
        break;
      case ActionType.SWITCH_WHO_PAY_LESS:
        break;
      case ActionType.PAY_NOTHING:
        break;
      default:
        throw UnimplementedError();
    }

    doubleValue = (maxPct - minPct) * doubleValue +
        minPct; // o valor será entre o mínimo e o máximo

    doubleValue = double.parse(doubleValue.toStringAsPrecision(1));

    intValue = (100 * doubleValue).toInt();

    action.setValues(
        doubleValue: doubleValue, intValue: intValue, boolValue: boolValue);

    return action;
  }

  void accept() {
    Choice choice = getCurrentChoice();

    double previousPlayerBill = players[currentPlayerIndex].bill;
    bool reverseEffect = false;
    double diff = 0;

    if (choice.consequence.isEffectBeforeAction) {
      // switch (choice.consequence.id) {
      //   case
      //   default:
      //     break;
      // }
      // reverseEffect
    }

    switch (choice.action.type) {
      case ActionType.PAY_LESS:
      case ActionType.PAY_MORE:
        double calcValue = choice.action.type == ActionType.PAY_LESS ? 1 : -1;
        calcValue = calcValue * choice.action.doubleValue;

        players[currentPlayerIndex].bill *= 1 - calcValue;

        diff = previousPlayerBill - players[currentPlayerIndex].bill;
        diff = diff / (players.length - 1);

        for (var p in players) {
          if (p != players[currentPlayerIndex]) {
            p.bill += diff;
          }
        }
        break;
      case ActionType.PAY_NOTHING:
        players[currentPlayerIndex].bill = 0;

        diff = previousPlayerBill - players[currentPlayerIndex].bill;
        diff = diff / (players.length - 1);

        for (var p in players) {
          if (p != players[currentPlayerIndex]) {
            p.bill += diff;
          }
        }

        break;
      case ActionType.SWITCH_WHO_PAY_LESS:
        PlayerStatus? smallestPlayer;

        for (var p in players) {
          if (p != players[currentPlayerIndex]) {
            if (smallestPlayer == null) {
              smallestPlayer = p;
            } else {
              if (p.bill < smallestPlayer.bill) {
                smallestPlayer = p;
              }
            }
          }
        }

        if (smallestPlayer != null) {
          players[currentPlayerIndex].bill = smallestPlayer.bill;
          smallestPlayer.bill = previousPlayerBill;
        }

        break;
      default:
        throw UnimplementedError();
    }
  }

  void reject() {
    // Talvez no futuro hajam consequencias por rejeitar as escolhas
  }

  PlayerStatus getCurrentPlayer() {
    return players[currentPlayerIndex];
  }

  void nextPlayer() {
    if (currentPlayerIndex == players.length - 1) {
      currentPlayerIndex = 0;
    } else {
      currentPlayerIndex++;
    }
  }
}
