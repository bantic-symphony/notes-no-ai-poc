import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:testing_riverpod/data/models/notes/note_dto.dart';
import 'package:synchronized/synchronized.dart';

class NoteDatabase {
  NoteDatabase._internal();
  static final NoteDatabase instance = NoteDatabase._internal();

  static final Lock _lock = Lock();
  static Database? _database;

  static const String _dbFile = 'notes.db';
  static const String notesTable = 'notes';

  Future<Database> get database => _lock.synchronized(() async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  });

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/$_dbFile';
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute('''
        CREATE TABLE $notesTable (
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          content TEXT NOT NULL,
          created_at TEXT NOT NULL
        )
      ''');
  }

  Future<int> addNote(NoteDto note) async {
    final db = await database;
    return await db.insert(
      notesTable,
      note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateNote(NoteDto note) async {
    final db = await database;
    return await db.update(
      notesTable,
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteNote(NoteDto note) async {
    final db = await database;
    return await db.delete(notesTable, where: 'id = ?', whereArgs: [note.id]);
  }

  Future<List<Map<String, dynamic>>?> getAllNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> notesMaps = await db.query(notesTable);

    if (notesMaps.isEmpty) return null;

    return notesMaps;
  }

  Future<List<Map<String, dynamic>>> getNote(String noteId) async {
    final db = await database;
    return await db.query(
      notesTable,
      where: "id = ?",
      whereArgs: [noteId],
      limit: 1,
    );
  }
}
