import 'dart:async';

import 'package:flutter/widgets.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE match(id INTEGER PRIMARY KEY AUTOINCREMENT, bill DECIMAL(8, 2))',
      );

      await db.execute(
        '''
        CREATE TABLE match_players(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR(120),
          bill DECIMAL(8, 2),
          match_id INTEGER NOT NULL,
          FOREING KEY (match_id) REFERENCES match(id)
        )
      ''',
      );
    },
    version: 1,
  );

  Future<void> insertDog(Dog dog) async {
    final db = await database;

    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Dog>> dogs() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('dogs');

    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  Future<void> updateDog(Dog dog) async {
    final db = await database;

    await db.update(
      'dogs',
      dog.toMap(),
      where: 'id = ?',
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    final db = await database;

    await db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  var fido = Dog(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  await insertDog(fido);

  print(await dogs());
  fido = Dog(
    id: fido.id,
    name: fido.name,
    age: fido.age + 7,
  );
  await updateDog(fido);

  print(await dogs());
  await deleteDog(fido.id);

  print(await dogs());
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
