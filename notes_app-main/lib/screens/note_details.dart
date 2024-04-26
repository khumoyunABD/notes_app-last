import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/logic/note_controller.dart';
import 'package:notes/models/note.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  //delete function
  void deleteNote(String id) async {
    Get.find<NoteController>().deleteNote(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Success'),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.title),
        actions: [
          IconButton(
            onPressed: () {
              deleteNote(widget.note.id);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                widget.note.title,
                style: const TextStyle(color: Colors.orange),
              ),
              Image.file(widget.note.image),
              Text(
                widget.note.description,
                style: const TextStyle(color: Colors.yellowAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
