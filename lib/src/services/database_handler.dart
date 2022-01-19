import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE matches(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            bill DECIMAL(8, 2),
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP
        );''',
        );

        await db.execute(
          '''CREATE TABLE match_players(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR(120),
          bill DECIMAL(8, 2),
          match_id INTEGER NOT NULL,
          FOREIGN KEY (match_id) REFERENCES matches(id)
        );''',
        );
      },
      version: 1,
    );
  }
}