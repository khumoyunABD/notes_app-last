import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/logic/note_controller.dart';
import 'package:notes/models/note.dart';
import 'package:transparent_image/transparent_image.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({
    super.key,
    required this.myNote,
    required this.onSelectNote,
  });

  final Note myNote;
  final void Function(Note note) onSelectNote;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  //delete function
  void deleteNote(String id) async {
    Get.find<NoteController>().deleteNote(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note has been deleted'),
      ),
    );
  }

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
        btnCancelOnPress: () {
          deleteNote(widget.myNote.id);
        },
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
            widget.onSelectNote(widget.myNote);
          },
          onLongPress: () {
            deleteDialog();
          },
          child: Column(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: FileImage(widget.myNote.image),
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
                      widget.myNote.title,
                      style: const TextStyle(color: Colors.amber),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.myNote.description,
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
