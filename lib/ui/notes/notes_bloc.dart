import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_riverpod/core/error/result.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/domain/model/home/notes.dart';
import 'package:testing_riverpod/domain/usecase/notes/delete_note_usecase.dart';
import 'package:testing_riverpod/domain/usecase/notes/get_all_notes_usecase.dart';
import 'package:testing_riverpod/ui/notes/notes_event.dart';
import 'package:testing_riverpod/ui/notes/notes_state.dart';
import 'package:testing_riverpod/ui/notes/widget/filter_popup_menu.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetAllNotesUsecase _getAllNotesUsecase;
  final DeleteNoteUsecase _deleteNoteUsecase;

  final Notes _notes = Notes(notes: List.empty(growable: true));

  NotesBloc(this._getAllNotesUsecase, this._deleteNoteUsecase)
    : super(Loading()) {
    on<FetchNotes>(_fetchAllNotes);
    on<NavigateToNewNote>(_goToNewNote);
    on<DeleteNote>(_deleteNote);
    on<FilterNotes>(_filterNotes);
  }

  void _fetchAllNotes(FetchNotes event, Emitter<NotesState> emit) async {
    final result = await _getAllNotesUsecase();
    final value = switch (result) {
      Success() => _handleSuccess(result.value),
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
      Success() => emit(NoteDeleted()),
      Failure() => emit(_handleError(result.value)),
    };
  }

  void _filterNotes(FilterNotes event, Emitter<NotesState> emit) async {
    switch (event.option) {
      case FilterOptions.byDate:
        _notes.notes.sort((Note a, Note b) => b.id.compareTo(a.id));
      case FilterOptions.byTitle:
        _notes.notes.sort(
          (Note a, Note b) =>
              a.title[0].toLowerCase().compareTo(b.title[0].toLowerCase()),
        );
    }
    emit(Loaded(notes: _notes));
  }

  Error _handleError(Exception exctepion) {
    return Error(message: exctepion.toString());
  }

  NotesState _handleSuccess(Notes notes) {
    _notes.notes.clear();
    _notes.notes.addAll(notes.notes);
    return Loaded(notes: _notes);
  }
}
