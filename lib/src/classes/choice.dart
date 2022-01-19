import 'package:conta_trap/src/classes/action.dart';
import 'package:conta_trap/src/classes/consequence.dart';

class Choice {
  final Action action;
  final Consequence consequence;

  const Choice({required this.action, required this.consequence});
}
