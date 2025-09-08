import 'package:testing_riverpod/domain/model/home/note.dart';

abstract class NoteDetailsState {}

class Created extends NoteDetailsState {
  final bool isUpdated;
  Created(this.isUpdated);
}

class LoadingNote extends NoteDetailsState {}

class NoteLoaded extends NoteDetailsState {
  final Note note;
  final String screenTitle;
  NoteLoaded({required this.note, required this.screenTitle});
}

class NoTitleError extends NoteDetailsState {}

class NotSavedError extends NoteDetailsState {}

class FailedLoadingNote extends NoteDetailsState {}
