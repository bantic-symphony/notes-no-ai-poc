import 'package:flutter/material.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';

class NoteCard extends StatelessWidget {
  NoteCard({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(
      children: [
        Text(note.title),
        Text(note.description)
      ],
    ));
  }
}
