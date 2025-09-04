import 'package:testing_riverpod/domain/model/home/note.dart';

abstract class NotesEvent {}

class FetchNotes extends NotesEvent {}

class NavigateToNewNote extends NotesEvent {
  String noteId;
  NavigateToNewNote({this.noteId = "-1"});
}

class DeleteNote extends NotesEvent {
  Note note;
  DeleteNote(this.note);
}
