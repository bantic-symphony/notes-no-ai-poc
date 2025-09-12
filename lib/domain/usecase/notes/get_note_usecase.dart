import 'package:testing_riverpod/core/error/result.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/domain/repo/notes_repositroy.dart';

class GetNoteUsecase {
  final NotesRepository _repo;

  GetNoteUsecase(this._repo);

  Future<Result<Note>> call(String noteId) async {
    return await _repo.fetchNote(noteId);
  }
}
