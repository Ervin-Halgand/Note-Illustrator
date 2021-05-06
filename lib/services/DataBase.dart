import 'dart:convert';

import 'package:note_illustrator/models/NotesModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBase {
  static Future<Database> database;
  void openDataBase() async {
    database =
        openDatabase(join(await getDatabasesPath(), 'Note_Illustrator.db'),
            onCreate: (db, version) {
      print("creted");
      return db.execute(
        "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, timestamp TEXT, title TEXT, description TEXT, audioRecords TEXT, images TEXT)",
      );
    }, version: 1);
  }

  Future<void> insertNotes(NotesModel note) async {
    // Get a reference to the database.
    final Database db = await database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NotesModel>> notes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (i) {
      /* print(jsonDecode(maps[i]['images']));
      print(jsonDecode(maps[i]['audioRecords'])); */
      final NotesModel model = NotesModel(
          id: maps[i]['id'],
          timestamp: maps[i]['timestamp'],
          title: maps[i]['title'],
          description: maps[i]['description'],
          images: jsonDecode(maps[i]['images']),
          audioRecords: jsonDecode(maps[i]['audioRecords']));
      return model;
    });
  }
}
