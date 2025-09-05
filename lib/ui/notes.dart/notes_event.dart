import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/ui/notes.dart/widget/filter_popup_menu.dart';

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

class FilterNotes extends NotesEvent {
  FilterOptions option;

  FilterNotes({required this.option});
}
