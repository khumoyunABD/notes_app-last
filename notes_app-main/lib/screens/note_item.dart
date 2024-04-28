import 'package:awesome_dialog/awesome_dialog.dart';
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
    void deleteDialog() {
      AwesomeDialog(
        btnOkText: 'Нет',
        btnCancelText: 'Да',
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Хотите удалить заметку?',
        desc: 'Точно хотите удалить заметку?',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }

    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            onSelectNote(myNote);
          },
          onLongPress: () {
            deleteDialog();
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
