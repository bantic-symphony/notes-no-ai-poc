import 'package:testing_riverpod/domain/model/home/note.dart';

abstract class NoteDetailsEvent {}

class SaveNote extends NoteDetailsEvent {
  final Note note;
  SaveNote(this.note);
}

class GetNote extends NoteDetailsEvent {
  final String noteId;
  GetNote(this.noteId);
}