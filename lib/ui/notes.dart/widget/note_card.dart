import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testing_riverpod/app_router.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/ui/notes.dart/notes_bloc.dart';
import 'package:testing_riverpod/ui/notes.dart/notes_event.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(note.createdAt.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<NotesBloc>().add(DeleteNote(note));
      },
      child: InkWell(
        onTap: () => GoRouter.of(context).pushNamed(
          AppRoutes.noteDetails,
          pathParameters: {"id": "${note.id}"},
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    note.title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Divider(height: 5, indent: 4, endIndent: 4),
                Text(
                  note.content,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle().copyWith(
                    color: Colors.black.withAlpha(150),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
