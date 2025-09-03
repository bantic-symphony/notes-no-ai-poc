import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_riverpod/core/error/result.dart';
import 'package:testing_riverpod/domain/usecase/notes/get_note_usecase.dart';
import 'package:testing_riverpod/domain/usecase/notes/store_note_usecase.dart';
import 'package:testing_riverpod/ui/notes.dart/details/note_details_event.dart';
import 'package:testing_riverpod/ui/notes.dart/details/note_details_state.dart';

class NoteDetailsBloc extends Bloc<NoteDetailsEvent, NoteDetailsState> {
  final StoreNoteUsecase _storeNoteUsecase;
  final GetNoteUsecase _getNoteUseCase;

  NoteDetailsBloc(this._storeNoteUsecase, this._getNoteUseCase)
    : super(LoadingNote()) {
    on<SaveNote>(_saveNote);
    on<GetNote>(_getNote);
  }

  void _saveNote(SaveNote event, Emitter<NoteDetailsState> emit) async {
    final result = await _storeNoteUsecase(event.note);
    switch (result) {
      case Success<int>():
        emit(Created());
      case Failure<int>():
        emit(NotSavedError());
    }
  }

  void _getNote(GetNote event, Emitter<NoteDetailsState> emit) async {
    if (event.noteId == "-1") return;
    emit(LoadingNote());
    final result = await _getNoteUseCase(event.noteId);
    switch (result) {
      case Success():
        emit(NoteLoaded(result.value));
      case Failure():
        emit(FailedLoadingNote());
    }
  }
}
