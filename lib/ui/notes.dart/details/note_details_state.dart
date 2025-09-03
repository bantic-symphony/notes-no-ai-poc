import 'package:testing_riverpod/domain/model/home/note.dart';

abstract class NoteDetailsState {}

class Created extends NoteDetailsState {}

class LoadingNote extends NoteDetailsState {}

class NoteLoaded extends NoteDetailsState {
  final Note note;
  NoteLoaded(this.note);
}

class NoTitleError extends NoteDetailsState {}

class NotSavedError extends NoteDetailsState {}

class FailedLoadingNote extends NoteDetailsState {}
