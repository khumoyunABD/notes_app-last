import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/screens/note_details.dart';
import 'package:notes/screens/note_item.dart';

class NotesList extends StatelessWidget {
  const NotesList({
    super.key,
    required this.notes,
  });

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    void selectNote(BuildContext context, Note note) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => NoteDetailsScreen(note: note)));
    }

    if (notes.isEmpty) {
      return Center(
        child: Text(
          'Нет заметок!',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 1,
      ),
      itemCount: notes.length,
      itemBuilder: (ctx, index) => NoteItem(
        myNote: notes[index],
        onSelectNote: (myNote) {
          selectNote(context, myNote);
        },
      ),
    );
  }
}
