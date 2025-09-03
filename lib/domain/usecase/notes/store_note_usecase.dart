import 'package:testing_riverpod/core/error/result.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/domain/repo/notes_repositroy.dart';

class StoreNoteUsecase {
  final NotesRepository repo;
  const StoreNoteUsecase(this.repo);

  Future<Result<int>> call(Note note) => repo.addNote(note);
}
