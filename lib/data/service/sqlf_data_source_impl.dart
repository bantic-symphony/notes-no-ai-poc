import 'package:logger/logger.dart';
import 'package:testing_riverpod/data/datasource/note_database.dart';
import 'package:testing_riverpod/data/datasource/sqlf_data_source.dart';
import 'package:testing_riverpod/data/models/notes/note_dto.dart';

class SqlfDataSourceImpl implements SqlfDataSource {
  SqlfDataSourceImpl({required this.database, required this.logger});

  final NoteDatabase database;
  final Logger logger;

  @override
  Future<List<NoteDto>> fetchNotes() async {
    List<Map<String, dynamic>>? notesMaps = await database.getAllNotes();

    if (notesMaps == null || notesMaps.isEmpty) {
      throw Exception("No notes created.");
    }

    return List.generate(
      notesMaps.length,
      (index) => NoteDto.fromJson(notesMaps[index]),
    );
  }

  @override
  Future<int> addNote(NoteDto note) async {
    return await database.addNote(note);
  }

  @override
  Future<int> updateNote(NoteDto note) async {
    return await database.updateNote(note);
  }

  @override
  Future<int> deleteNote(NoteDto note) async {
    return await database.deleteNote(note);
  }

  @override
  Future<NoteDto> getNote(String noteId) async {
    if (noteId.isEmpty || noteId == "-1") {
      throw Exception("Note with id:$noteId does not exsit.");
    }

    List<Map<String, dynamic>>? noteJson = await database.getNote(noteId);

    if (noteJson.isEmpty) {
      throw Exception("Note with id $noteId does not exsit.");
    }

    return List.generate(
      noteJson.length,
      (index) => NoteDto.fromJson(noteJson[index]),
    ).first;
  }
}
