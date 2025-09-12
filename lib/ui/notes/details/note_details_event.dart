abstract class NoteDetailsEvent {}

class SaveNote extends NoteDetailsEvent {
  final String title;
  final String content;
  SaveNote({required this.title, required this.content});
}

class GetNote extends NoteDetailsEvent {
  final String noteId;
  GetNote(this.noteId);
}
