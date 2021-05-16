import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_illustrator/models/NotesModel.dart';
import 'package:note_illustrator/models/UserInfoModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer' as developer;

class DataBase {
  static Future<Database> database;
  Future<void> openDataBase() async {
    database =
        openDatabase(join(await getDatabasesPath(), 'Note_Illustrator.db'),
            onCreate: (db, version) async {
      print("creted");
      db.execute(
        "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, timestamp TEXT, title TEXT, description TEXT, audioRecords TEXT, images TEXT)",
      );
      db.execute(
        "CREATE TABLE userInfo(id INTEGER PRIMARY KEY, userName TEXT, image TEXT)",
      );
      await db.execute(
        "CREATE TABLE habitNotes(id INTEGER PRIMARY KEY NOT NULL, timestamp TEXT, title TEXT, description TEXT, audioRecords TEXT, images TEXT)",
      );
      initHabitNotes();
    }, version: 1);
  }

  Future<void> insertUser(UserInfoModel user) async {
    final Database db = await database;

    await db.insert(
      'userInfo',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUser(UserInfoModel user) async {
    final Database db = await database;

    await db.update(
      'userInfo',
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  Future<UserInfoModel> user() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('userInfo');
    if (maps.length == 0) return null;
    return UserInfoModel(
        userName: maps[0]['userName'], image: maps[0]['image']);
  }

  Future<void> insertNotes(NotesModel note) async {
    final Database db = await database;

    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> images() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("Select * from notes where images != '[]'");
    final List<String> images = [];
    for (int i = 0; i != maps.length; i++) {
      var imagesInNote = jsonDecode(maps[i]['images']);
      for (int n = 0; n != imagesInNote.length; n++) {
        images.add(imagesInNote[n]);
      }
    }
    return images;
  }

  Future<List<NotesModel>> notesSearched(String filter) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db
        .rawQuery("Select * from notes where title LIKE '%" + filter + "%'");
    // print(filter);
    // print(maps.length);
    return List.generate(maps.length, (i) {
      // print(maps);
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
    Future<void> updateNote(NotesModel note) async {
      final Database db = await database;

      await db.update(
        'notes',
        note.toMap(),
        where: "id = ?",
        whereArgs: [note.id],
      );
    }

    Future<void> deleteNote(int id) async {
      final db = await database;

      await db.delete(
        'notes',
        where: "id = ?",
        whereArgs: [id],
      );
    }

    Future<List<NotesModel>> notes() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('notes');

      return List.generate(maps.length, (i) {
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

    Future<List<NotesModel>> habitNotes() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('habitNotes');

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

    Future<void> updateHabitNote(NotesModel note) async {
      final Database db = await database;

      await db.update(
        'habitNotes',
        note.toMap(),
        where: "id = ?",
        whereArgs: [note.id],
      );
    }

    Future<void> initHabitNotes() async {
      final Database db = await database;
      DateTime date = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      String timestamp =
          "${date.day.toString()}-${date.month.toString()}-${date.year.toString()}";
      List<NotesModel> notes = [
        NotesModel(
            id: 1,
            title: "Monday",
            timestamp: timestamp,
            description: "Monday description",
            audioRecords: [],
            images: []),
        NotesModel(
            id: 2,
            title: "Tuesday",
            timestamp: timestamp,
            description: "Tuesday description",
            audioRecords: [],
            images: []),
        NotesModel(
            id: 3,
            title: "Wednesday",
            timestamp: timestamp,
            description: "Wednesday description",
            audioRecords: [],
            images: []),
        NotesModel(
            id: 4,
            title: "Thursday",
            timestamp: timestamp,
            description: "Thursday description",
            audioRecords: [],
            images: []),
        NotesModel(
            id: 5,
            title: "Friday",
            timestamp: timestamp,
            description: "Friday description",
            audioRecords: [],
            images: []),
        NotesModel(
            id: 6,
            title: "Saturday",
            timestamp: timestamp,
            description: "Saturday description",
            audioRecords: [],
            images: []),
        NotesModel(
            id: 7,
            title: "Sunday",
            timestamp: timestamp,
            description: "Sunday description",
            audioRecords: [],
            images: []),
      ];

      notes.forEach((note) async {
        await db.insert(
          'habitNotes',
          note.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
    }
  }
