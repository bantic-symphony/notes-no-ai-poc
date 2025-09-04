import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/domain/model/home/notes.dart';

abstract class NotesState {}

class Loading extends NotesState {}

class Loaded extends NotesState {
  final Notes notes;
  Loaded({required this.notes});
}

class NoteDeleted extends NotesState {
  Note note;
  NoteDeleted(this.note);
}

class Emtpy extends NotesState {}

class GoToNewNote extends NotesState {
  String noteId;
  GoToNewNote({this.noteId = "-1"});
}

class Error extends NotesState {
  final String message;
  Error({required this.message});
}
