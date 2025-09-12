import 'package:testing_riverpod/core/error/result.dart';
import 'package:testing_riverpod/domain/model/home/notes.dart';
import 'package:testing_riverpod/domain/repo/notes_repositroy.dart';

class GetAllNotesUsecase {
  final NotesRepository _repo;
  GetAllNotesUsecase(this._repo);

  Future<Result<Notes>> call() async => await _repo.fetchNotes();
}
