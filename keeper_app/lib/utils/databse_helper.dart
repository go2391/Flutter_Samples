import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:keeper_app/models/note.dart';

class DataBaseHelper {
  static DataBaseHelper _dataBaseHelper;

  // ignore: unused_field
  static Database _database;
  String noteTable = "noteTable";
  String colId = "ID";
  String colTitle = "Title";
  String colDescription = "Description";
  String colDate = "Date";
  String colPriority = "Priority";

  DataBaseHelper._createInstance();

  factory DataBaseHelper() {
    if (_dataBaseHelper == null) {
      _dataBaseHelper = DataBaseHelper._createInstance();
    }
    return _dataBaseHelper;
  }



  Future<Database> initializeDataBase() async {
    //get the path directory to store db
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
    debugPrint(' -----   $path');
    //open data base and pass create
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);


    return notesDatabase;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDataBase();
    }
    return _database;
  }

  void _createDb(Database db, int newVersion) async {
    debugPrint(' -----   create');
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colTitle TEXT,$colDescription TEXT,$colPriority INTEGER,$colDate TEXT)');


  }

  //fetch operation
  Future<List<Map<String, dynamic>>> getNotesMapList() async {
    Database db = await this.database;

    var result = await db.query(noteTable, orderBy: '$colPriority ASC');

    return result;
  }

  //insert operation

  Future<int> insertNote(Note note) async {
    var db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  //update operation

  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  //delete operation

  Future<int> deleteNote(Note note) async {
    var db = await this.database;
    var result =
        await db.delete(noteTable, where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  //get no of rows
  Future<int> getCount() async {
    var db = await this.database;
    List<Map<String, dynamic>> result = await db.query(noteTable);
    int count = Sqflite.firstIntValue(result);
    return count;
  }

  //get the map list
  Future<List<Note>> getNotesList() async {
    var noteMaplist = await getNotesMapList();
    int size = noteMaplist.length;

    List<Note> _notesList = List<Note>();
    for (int i = 0; i < size; i++) {
      _notesList.add(Note.fromMapToObject(noteMaplist[i]));
    }

    return _notesList;
  }
}
