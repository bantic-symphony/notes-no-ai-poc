import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_riverpod/core/error/result.dart';
import 'package:testing_riverpod/domain/usecase/notes/delete_note_usecase.dart';
import 'package:testing_riverpod/domain/usecase/notes/get_all_notes_usecase.dart';
import 'package:testing_riverpod/ui/notes.dart/notes_event.dart';
import 'package:testing_riverpod/ui/notes.dart/notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetAllNotesUsecase _getAllNotesUsecase;
  final DeleteNoteUsecase _deleteNoteUsecase;

  NotesBloc(this._getAllNotesUsecase, this._deleteNoteUsecase)
    : super(Loading()) {
    on<FetchNotes>(_fetchAllNotes);
    on<NavigateToNewNote>(_goToNewNote);
    on<DeleteNote>(_deleteNote);
  }

  void _fetchAllNotes(FetchNotes event, Emitter<NotesState> emit) async {
    final result = await _getAllNotesUsecase();
    final value = switch (result) {
      Success() => Loaded(notes: result.value),
      Failure() => _handleError(result.value),
    };
    emit(value);
  }

  void _goToNewNote(NavigateToNewNote event, Emitter<NotesState> emit) async {
    emit(GoToNewNote(noteId: event.noteId));
  }

  void _deleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    emit(Loading());
    final result = await _deleteNoteUsecase(event.note);
    final _ = switch (result) {
      Success() => add(FetchNotes()),
      Failure() => emit(_handleError(result.value)),
    };
  }

  Error _handleError(Exception exctepion) {
    return Error(message: exctepion.toString());
  }
}
