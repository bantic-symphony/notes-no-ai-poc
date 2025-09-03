import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testing_riverpod/app_router.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => 
      GoRouter.of(
        context,
      ).pushNamed(AppRoutes.noteDetails, pathParameters: {"id" : "${note.id}"}),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
            Divider(height: 5, indent: 4, endIndent: 4),
            Text(
              note.content,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle().copyWith(color: Colors.black.withAlpha(150)),
            ),
          ],
        ),
      ),
    );
  }
}
