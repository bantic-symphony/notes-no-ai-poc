import 'package:flutter/material.dart';
import 'package:testing_riverpod/domain/model/home/note.dart';

class NoteDetailsContent extends StatefulWidget {
  const NoteDetailsContent({super.key, required this.note});

  final Note note;

  @override
  State<NoteDetailsContent> createState() => _NoteDetailsContentState();
}

class _NoteDetailsContentState extends State<NoteDetailsContent> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _desriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title;
    _desriptionController.text = widget.note.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done_outline),
        onPressed: () {}
        ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder()
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
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder()
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
