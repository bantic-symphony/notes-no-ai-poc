import 'package:flutter/material.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/ui/home/widget/note_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              NoteCard(note: Note(id: 1, title: "First", description: "Description of my First note"),),
              NoteCard(note: Note(id: 2, title: "Second", description: "Description of my Second note")),
              NoteCard(note: Note(id: 3, title: "The one after Second", description: "Description of my Third note"))
            ],
          ),
        ),
      ),
    );
  }
}
