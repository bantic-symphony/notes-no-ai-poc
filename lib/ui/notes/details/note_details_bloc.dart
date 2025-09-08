import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_riverpod/core/error/result.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/domain/usecase/notes/get_note_usecase.dart';
import 'package:testing_riverpod/domain/usecase/notes/store_note_usecase.dart';
import 'package:testing_riverpod/ui/notes/details/note_details_event.dart';
import 'package:testing_riverpod/ui/notes/details/note_details_state.dart';

class NoteDetailsBloc extends Bloc<NoteDetailsEvent, NoteDetailsState> {
  final StoreNoteUsecase _storeNoteUsecase;
  final GetNoteUsecase _getNoteUseCase;

  Note _note = Note();

  NoteDetailsBloc(this._storeNoteUsecase, this._getNoteUseCase)
    : super(LoadingNote()) {
    on<SaveNote>(_saveNote);
    on<GetNote>(_getNote);
  }

  void _saveNote(SaveNote event, Emitter<NoteDetailsState> emit) async {
    final result = await _storeNoteUsecase(
      _note.copyWith(title: event.title, content: event.content),
    );
    switch (result) {
      case Success():
        emit(Created(_note.id != -1));
      case Failure():
        emit(NotSavedError());
    }
  }

  void _getNote(GetNote event, Emitter<NoteDetailsState> emit) async {
    if (event.noteId == "-1") {
      emit(
        NoteLoaded(
          note: Note(id: int.parse(event.noteId)),
          screenTitle: "Create note"
        ),
      );
      return;
    }
    emit(LoadingNote());
    final result = await _getNoteUseCase(event.noteId);
    switch (result) {
      case Success():
        _note = result.value;
        emit(NoteLoaded(note: result.value, screenTitle: "Edit note"));
      case Failure():
        emit(FailedLoadingNote());
    }
  }
}
