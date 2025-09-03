import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';
import 'package:testing_riverpod/ui/notes.dart/details/note_details_bloc.dart';
import 'package:testing_riverpod/ui/notes.dart/details/note_details_event.dart';
import 'package:testing_riverpod/ui/notes.dart/details/note_details_state.dart';

class NoteDetailsContent extends StatefulWidget {
  const NoteDetailsContent({super.key});

  @override
  State<NoteDetailsContent> createState() => _NoteDetailsContentState();
}

class _NoteDetailsContentState extends State<NoteDetailsContent> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _desriptionController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   _titleController.text = widget.note.title;
  //   _desriptionController.text = widget.note.content;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done_outline),
        onPressed: () {
          final nowTimestamp = DateTime.now().millisecondsSinceEpoch;
          final note = Note(
            id: nowTimestamp,
            content: _desriptionController.text,
            title: _titleController.text,
            createdAt: nowTimestamp,
          );
          context.read<NoteDetailsBloc>().add(SaveNote(note));
        },
      ),
      body: BlocBuilder<NoteDetailsBloc, NoteDetailsState>(
        builder: (context, state) {
          if (state is NoteLoaded) {
            _titleController.text = state.note.title;
            _desriptionController.text = state.note.content;
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: "Title",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(height: 1),
                    ),
                    TextFormField(
                      controller: _desriptionController,
                      maxLines: 20,
                      expands: false,
                      decoration: InputDecoration(
                        labelText: "Description",
                        alignLabelWithHint: true,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
