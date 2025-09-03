import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:testing_riverpod/app_router.dart';
import 'package:testing_riverpod/domain/model/home/notes.dart';
import 'package:testing_riverpod/ui/notes.dart/notes_bloc.dart';
import 'package:testing_riverpod/ui/notes.dart/notes_event.dart';
import 'package:testing_riverpod/ui/notes.dart/notes_state.dart';
import 'package:testing_riverpod/ui/notes.dart/widget/note_card.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return context.read<NotesBloc>().add(FetchNotes());
      },
      child: Scaffold(
        body: BlocConsumer<NotesBloc, NotesState>(
          listener: (context, state) {
            switch (state) {
              case GoToNewNote():
                GoRouter.of(context).pushNamed(
                  AppRoutes.noteDetails,
                  pathParameters: {"id": state.noteId},
                );
            }
          },
          builder: (context, state) {
            return switch (state) {
              Loaded() => _loadedContent(state.notes, context),
              Emtpy() => _noNotesContent(),
              _ => _noNotesContent(),
            };
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.read<NotesBloc>().add(NavigateToNewNote());
          },
          label: Text("New note"),
        ),
      ),
    );
  }

  Widget _loadedContent(Notes notes, BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: notes.notes
              .map<Widget>((note) => NoteCard(note: note))
              .toList(),
        ),
      ),
    );
  }

  Widget _noNotesContent() {
    return Expanded(child: Center(child: Text("No notes created")));
  }
}
