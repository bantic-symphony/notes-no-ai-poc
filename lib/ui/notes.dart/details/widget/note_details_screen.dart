import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testing_riverpod/ui/notes.dart/details/note_details_bloc.dart';
import 'package:testing_riverpod/ui/notes.dart/details/note_details_state.dart';
import 'package:testing_riverpod/ui/notes.dart/details/widget/note_details_content.dart';

class NoteDetailsScreen extends StatelessWidget {
  const NoteDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteDetailsBloc, NoteDetailsState>(
      listener: (context, state) => {
        if (state == Created())
          {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: const Text('Note created!'))),

            context.pop(),
          },
      },
      child: NoteDetailsContent(),
    );
  }
}
