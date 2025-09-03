import 'package:logger/logger.dart';
import 'package:testing_riverpod/data/mappers/notes_mappers.dart';
import 'package:testing_riverpod/data/service/note_service.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/domain/model/home/notes.dart';
import 'package:testing_riverpod/domain/repo/notes_repositroy.dart';

import '../../core/error/result.dart';

class NotesRepositoryImpl implements NotesRepository {
  const NotesRepositoryImpl({required this.logger, required this.service});

  final Logger logger;
  final NoteService service;

  @override
  Future<Result<Notes>> fetchNotes() async {
    try {
      final result = await service.getNotes();
      final notes = Notes(notes: result.map ((dto) => dto.toDomain()).toList(growable: false));
      return Success(notes);
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<int>> addNote(Note note) async {
    try {
      final result = await service.addNote(note.toDto());
      return Success(result);
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<int>> deleteNote(Note note) async {
    try {
      final result = await service.deleteNote(note.toDto());
      return Success(result);
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<int>> updateNote(Note note) async {
    try {
      final result = await service.updateNote(note.toDto());
      return Success(result);
    } catch (e) {
      return Failure(Exception(e));
    }
  }
  
  @override
  Future<Result<Note>> fetchNote(String noteId) async {
    try {
      final result = await service.getNote(noteId);
      return Success(result.toDomain());
    } catch(e) {
      return Failure(Exception(e.toString()));
    }
  }
}
