import 'package:conta_trap/src/utils/choices_controller.dart';

class Match {
  late int id;
  late List<MatchPlayer> players;
  int? playersLength;
  late DateTime createdAt;

  double bill;

  Match({required this.bill});

  static Match fromMap(Map<String, dynamic> res) {
    return Match(bill: res["bill"].toDouble())
      ..createdAt = DateTime.parse(res["created_at"])
      ..id = res["id"];
  }

  static Match fromMatchController(MatchController controller) {
    Match match = Match(bill: controller.bill);

    match.players = controller.players
        .map((e) => MatchPlayer(bill: e.bill, name: e.name))
        .toList();

    return match;
  }
}

class MatchPlayer {
  final String name;
  final double bill;

  MatchPlayer({required this.name, required this.bill});

  static MatchPlayer fromMap(Map<String, dynamic> res) {
    return MatchPlayer(
      bill: res["bill"].toDouble(),
      name: res["name"],
    );
  }
}
