import 'package:conta_trap/src/classes/match.dart';
import 'package:conta_trap/src/services/database_handler.dart';
import 'package:sqflite/sqflite.dart';

class MatchDAO {
  final DatabaseHandler databaseHandler;

  const MatchDAO({required this.databaseHandler});

  Future<int> save(Match match) async {
    final Database db = await databaseHandler.initializeDB();

    // Save Match
    final int matchId = await db.insert('matches', {'bill': match.bill});

    // Save Players
    for (MatchPlayer matchPlayer in match.players) {
      await db.insert('match_players', {
        'match_id': matchId,
        'name': matchPlayer.name,
        'bill': matchPlayer.bill,
      });
    }

    return matchId;
  }

  Future<List<Match>> list() async {
    final Database db = await databaseHandler.initializeDB();

    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
      'SELECT m.id, m.bill, m.created_at, COUNT(mp.id) as players FROM matches m LEFT JOIN match_players mp ON m.id = mp.match_id GROUP BY m.id;',
    );

    return queryResult
        .map((res) => Match.fromMap(res)..playersLength = res["players"])
        .toList();
  }

  Future<Match> get(int matchId) async {
    final Database db = await databaseHandler.initializeDB();
    List<Map<String, dynamic>> queryResult;

    queryResult = await db.query('matches',
        where: "id = ?", whereArgs: [matchId], limit: 1);

    final Match match = Match.fromMap(queryResult[0]);

    queryResult = await db
        .query('match_players', where: "match_id = ?", whereArgs: [matchId]);

    return match
      ..players = queryResult.map((res) => MatchPlayer.fromMap(res)).toList();
  }
}
