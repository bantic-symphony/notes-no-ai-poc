import 'package:testing_riverpod/core/error/result.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/domain/repo/notes_repositroy.dart';

class DeleteNoteUsecase {
  final NotesRepository _repo;

  DeleteNoteUsecase(this._repo);

  Future<Result<int>> call(Note note) async {
    return _repo.deleteNote(note);
  }
}
