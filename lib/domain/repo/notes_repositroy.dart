import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/domain/model/home/notes.dart';

import '../../core/error/result.dart';

abstract class NotesRepository {
  Future<Result<Notes>> fetchNotes();
  Future<Result<Note>> fetchNote(String noteId);
  Future<Result<int>> addNote(Note note);
  Future<Result<int>> updateNote(Note note);
  Future<Result<int>> deleteNote(Note note);
}
