// needed for Directory()
import 'dart:io';
// needed for SQL database operations
import 'package:sqflite/sqflite.dart';
// needed for getApplicationDocumentsDirectory()
import 'package:path_provider/path_provider.dart';

import 'model.dart';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}/$_databaseName';
    // Open the database, can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $infos (
            $columnId INTEGER PRIMARY KEY,
            $columnIdade TEXT ,
            $columnAltura TEXT ,
            $columnPeso TEXT ,
            $columnSexo TEXT 
          )
          ''');
  }

  // Database helper methods:

  Future<int> insert(
      String idade, String altura, String peso, String sexo) async {
    Database db = await database;
    int id = await db.insert(infos, Info);
    return id;
  }

/*
  Future<Word?> queryWord(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(infos,
        columns: [columnId, columnWord, columnFrequency],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Info.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Word>?> queryAllWords() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(infos);
    if (maps.length > 0) {
      List<Word> words = [];
      maps.forEach((map) => words.add(Word.fromMap(map)));
      return words;
    }
    return null;
  }
*/
  Future<int> deleteWord(int id) async {
    Database db = await database;
    return await db.delete(infos, where: '$columnId = ?', whereArgs: [id]);
  }
}
