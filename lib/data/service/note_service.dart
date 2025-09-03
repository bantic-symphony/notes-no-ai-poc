import 'package:testing_riverpod/data/models/notes/note_dto.dart';

abstract class NoteService {
  Future<List<NoteDto>> getNotes();
  Future<int> addNote(NoteDto note);
  Future<int> updateNote(NoteDto note);
  Future<int> deleteNote(NoteDto note);
  Future<NoteDto> getNote(String noteId);
}
