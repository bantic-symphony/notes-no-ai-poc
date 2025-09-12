import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testing_riverpod/ui/common/toast.dart';
import 'package:testing_riverpod/ui/notes/details/note_details_bloc.dart';
import 'package:testing_riverpod/ui/notes/details/note_details_state.dart';
import 'package:testing_riverpod/ui/notes/details/widget/note_details_content.dart';

class NoteDetailsScreen extends StatelessWidget {
  const NoteDetailsScreen({super.key});

  @override
  Widget build(BuildContext ctx) {
    return BlocListener<NoteDetailsBloc, NoteDetailsState>(
      listener: (context, state) {
        if (state is Created) {
          final String toastText = state.isUpdated
              ? 'Note updated!'
              : 'Note created!';
          notesSnackBar(context, toastText, Colors.greenAccent);

          context.pop(true);
        }
      },
      child: NoteDetailsContent(),
    );
  }
}
