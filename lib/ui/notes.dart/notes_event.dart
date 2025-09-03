abstract class NotesEvent {}

class FetchNotes extends NotesEvent {}

class NavigateToNewNote extends NotesEvent {
  String noteId;
  NavigateToNewNote({this.noteId = "-1"});
}
