import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
            if (state is NoteDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.note} deleted!'),
                  backgroundColor: Colors.redAccent,
                ),
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
          onPressed: () async {
            final result = await context.pushNamed<bool>(
              AppRoutes.noteDetails,
              pathParameters: {"id": "-1"},
            );
            if (result == true) {
              context.read<NotesBloc>().add(FetchNotes());
            }
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(child: Center(child: Text("No notes created"))),
      ),
    );
  }
}
