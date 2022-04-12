import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final todoTABLE = 'Todo';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) {
      print("database _database is exists");

      return _database!;
    } else {
      print("database createDatabase is exists");

      _database = await createDatabase();
      return _database!;
    }
  }

  createDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "data.db");
    Database? database;
    if (await Directory(dirname(path)).exists()) {
      database = await openDatabase(path, version: 1,   onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute('''
     create table $todoTABLE ( 
   id integer primary key autoincrement, 
   description text not null,
   is_done integer not null)
    ''');
        /*  await db.execute("CREATE TABLE $todoTABLE ("
                  "id INTEGER PRIMARY KEY,"
                  "description TEXT,"
                  "is_done INTEGER "
                  ")");*/
      });
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
        database = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('''
     create table $todoTABLE ( 
   id integer primary key autoincrement, 
   description text not null,
   is_done integer not null)
    ''');
          /*  await db.execute("CREATE TABLE $todoTABLE ("
                  "id INTEGER PRIMARY KEY,"
                  "description TEXT,"
                  "is_done INTEGER "
                  ")");*/
        });
      } catch (e) {
        // ignore: avoid_print
        print("database is not exists");

        print(e);
      }
    }
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $todoTABLE ("
        "id INTEGER PRIMARY KEY, "
        "description TEXT, "
        /*SQLITE doesn't have boolean type
        so we store isDone as integer where 0 is false
        and 1 is true*/
        "is_done INTEGER "
        ")");
  }
}
