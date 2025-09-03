import 'package:logger/logger.dart';
import 'package:testing_riverpod/core/error/data_exceptions.dart';
import 'package:testing_riverpod/data/datasource/sqlf_data_source.dart';
import 'package:testing_riverpod/data/models/notes/note_dto.dart';
import 'package:testing_riverpod/data/service/note_service.dart';

class NotesServiceImpl implements NoteService {
  final Logger logger;
  final SqlfDataSource dataSource;

  const NotesServiceImpl(this.dataSource, this.logger);

  @override
  Future<int> addNote(NoteDto note) async {
    try {
      final result = await dataSource.addNote(note);
      logger.i("Note added (\"${note.toString()}\")");
      return result;
    } catch (e) {
      logger.e("Adding note filed: $e");
      throw DatabaseDX(e.toString());
    }
  }

  @override
  Future<int> deleteNote(NoteDto note) async {
    try {
      final result = await dataSource.deleteNote(note);
      return result;
    } catch (e) {
      logger.e("Deleting note filed: $e");
      throw DatabaseDX(e.toString());
    }
  }

  @override
  Future<List<NoteDto>> getNotes() async {
    try {
      final result = await dataSource.fetchNotes();
      return result;
    } catch (e) {
      logger.e("Fetching notes filed: ${e.toString()}");
      throw DatabaseDX(e.toString());
    }
  }

  @override
  Future<int> updateNote(NoteDto note) async {
    try {
      final result = await dataSource.updateNote(note);
      return result;
    } catch (e) {
      logger.e("Updating note filed: $e");
      throw DatabaseDX(e.toString());
    }
  }

  @override
  Future<NoteDto> getNote(String noteId) async {
    try {
      final result = await dataSource.getNote(noteId);
      return result;
    } catch (e) {
      logger.e("Getting note filed: $e");
      throw DatabaseDX(e.toString());
    }
  }
}
