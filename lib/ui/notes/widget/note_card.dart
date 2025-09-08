import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testing_riverpod/app_router.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/ui/notes/notes_bloc.dart';
import 'package:testing_riverpod/ui/notes/notes_event.dart';

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
        child: SizedBox(
          height: double.infinity,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      note.title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                        // color: Theme.of(context).colorScheme.primaryContainer,
                      ).copyWith(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      note.content,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle().copyWith(
                        color: Colors.black.withAlpha(150),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      note.createdAt,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.grey),
                    ),
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
