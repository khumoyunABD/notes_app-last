import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/logic/note_controller.dart';
import 'package:notes/screens/add_note.dart';
import 'package:notes/screens/notes_list.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<NoteController>().loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    final notes = Get.find<NoteController>();

    final userNotes = GetBuilder<NoteController>(
        builder: (controller) => NotesList(notes: notes.notes));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Заметки'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 14,
          bottom: 14,
        ),
        child: IconButton.outlined(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
          ),
          iconSize: 40,
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const AddNoteScreen(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: userNotes,
      ),
    );
  }
}
