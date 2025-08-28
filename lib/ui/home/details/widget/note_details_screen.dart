import 'package:flutter/widgets.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/ui/home/details/widget/note_details_content.dart';

class NoteDetailsScreen extends StatelessWidget {
  const NoteDetailsScreen({required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return NoteDetailsContent(
      note: Note(id: int.parse(id), title: id, description: id),
    );
  }
}
