import 'package:testing_riverpod/data/models/notes/note_dto.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';

extension NoteDtoX on NoteDto {
  Note toDomain() =>
      Note(id: id, title: title, content: content, createdAt: createdAt);
}

extension NoteX on Note {
  NoteDto toDto() =>
      NoteDto(id: id, title: title, content: content, createdAt: createdAt);
}
