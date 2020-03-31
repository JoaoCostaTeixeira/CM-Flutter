import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Update the Dog class to include a `toMap` method.
class Alarme {
  final int id;
  final int horas;
  final int min;

  Alarme({this.id, this.horas, this.min});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': horas,
      'age': min,
    };
  }
}

   Future<Database> database () async{
      openDatabase(
            // Set the path to the database.
            join(await getDatabasesPath(), 'alarm_database.db'),
            // When the database is first created, create a table to store dogs.
            onCreate: (db, version) {
              // Run the CREATE TABLE statement on the database.
              return db.execute(
                "CREATE TABLE alarms(id INTEGER PRIMARY KEY, horas INTEGER, min INTEGER)",
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
Future<void> insertAlarm(Alarme alarm) async {
  // Get a reference to the database.
  final Database db = await database();

  await db.insert(
    'alarms',
    alarm.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}