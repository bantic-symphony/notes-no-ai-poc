import 'package:testing_riverpod/domain/model/home/notes.dart';

abstract class NotesState {}

class Loading extends NotesState {}

class Loaded extends NotesState {
  final Notes notes;
  Loaded({required this.notes});
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
