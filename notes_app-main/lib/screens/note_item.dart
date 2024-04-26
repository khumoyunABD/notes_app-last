import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:transparent_image/transparent_image.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.myNote,
    required this.onSelectNote,
  });

  final Note myNote;
  final void Function(Note note) onSelectNote;

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            onSelectNote(myNote);
          },
          child: Column(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: FileImage(myNote.image),
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 1,
                  horizontal: 3,
                ),
                child: Column(
                  children: [
                    Text(
                      myNote.title,
                      style: const TextStyle(color: Colors.amber),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      myNote.description,
                      style: const TextStyle(color: Colors.grey),
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
