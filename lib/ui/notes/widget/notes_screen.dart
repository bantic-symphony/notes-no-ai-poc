import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testing_riverpod/app_router.dart';
import 'package:testing_riverpod/domain/model/home/notes.dart';
import 'package:testing_riverpod/ui/notes/notes_bloc.dart';
import 'package:testing_riverpod/ui/notes/notes_event.dart';
import 'package:testing_riverpod/ui/notes/notes_state.dart';
import 'package:testing_riverpod/ui/notes/widget/filter_popup_menu.dart';
import 'package:testing_riverpod/ui/notes/widget/note_card.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return context.read<NotesBloc>().add(FetchNotes());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Notes"),
          actions: [
            FilterPopupMenu(
              onOptionTapped: (FilterOptions option) {
                context.read<NotesBloc>().add(FilterNotes(option: option));
              },
            ),
          ],
        ),
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
              Loading() => _loadingContent(),
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
            if (result == true && context.mounted) {
              context.read<NotesBloc>().add(FetchNotes());
            }
          },
          label: const Text("New note"),
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
              .map<Widget>(
                (note) => NoteCard(note: note, key: Key(note.id.toString())),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _noNotesContent() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(child: Center(child: const Text("No notes created"))),
      ),
    );
  }

  Widget _loadingContent() {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
