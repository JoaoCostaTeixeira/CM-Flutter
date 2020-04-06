import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Update the Dog class to include a `toMap` method.
class House {
  final int id;
  final String nome;
  final double lat;
final double long;

  House({this.id, this.nome, this.lat, this.long});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'lat': lat,
      'long' : long,
    };
  }
}

   Future<Database> database () async{
      openDatabase(
            // Set the path to the database.
            join(await getDatabasesPath(), 'house_database.db'),
            // When the database is first created, create a table to store dogs.
            onCreate: (db, version) {
              // Run the CREATE TABLE statement on the database.
              return db.execute(
                "CREATE TABLE house(id INTEGER PRIMARY KEY, nome TEXT, lat REAL, long REAL)",
              );
            },
            // Set the version. This executes the onCreate function and provides a
            // path to perform database upgrades and downgrades.
            version: 1,
          );
    } 



isCreated() async{
  await database();
}

// Define a function that inserts dogs into the database
Future<void> insertAlarm(House house) async {
  // Get a reference to the database.
  final Database db = await database();

  await db.insert(
    'house',
    house.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<House>> houses() async {
  // Get a reference to the database.
  final Database db = await database();

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('house');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return House(
      id: maps[i]['id'],
      nome: maps[i]['nome'],
      lat: maps[i]['lat'],
      long:  maps[i]['long'],
    );
  });
}