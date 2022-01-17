class Match {
  late int id;
  late List<MatchPlayer> players;
  late DateTime createdAt;

  double bill;

  Match({required this.bill});

  Match.fromMap(Map<String, dynamic> res)
      : createdAt = res["created_at"],
        id = res["id"],
        bill = res["bill"];
}

class MatchPlayer {
  final String name;
  final double bill;

  MatchPlayer({required this.name, required this.bill});

  MatchPlayer.fromMap(Map<String, dynamic> res)
      : name = res["name"],
        bill = res["bill"];
}
