import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/logic/note_controller.dart';
import 'package:notes/models/note.dart';
import 'package:notes/widgets/image_picker.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _selectedImage;

  void _saveEditedNote(String id) {
    final enteredTitle = _titleController.text;
    final enteredDescription = _descriptionController.text;
    //File? image;

    if (enteredTitle.isEmpty || enteredDescription.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Заполните все поля!'),
          duration: Duration(seconds: 3),
        ),
      );
    }
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Добавьте картинку!'),
          duration: Duration(seconds: 3),
        ),
      );
    }

    Get.find<NoteController>()
        .editNote(id, enteredTitle, _selectedImage!, enteredDescription);
    Get.find<NoteController>().loadNotes();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note has been updated successfully'),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменить заметку'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_add),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Заголовок',
                hintText: widget.note.title,
                hintStyle: const TextStyle(color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.tertiary),
              ),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              maxLines: null,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                errorMaxLines: 6,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                helperMaxLines: 8,
                hintText: widget.note.description,
                hintStyle: const TextStyle(color: Colors.grey),
                hintMaxLines: 6,
                contentPadding: const EdgeInsets.all(20),
                border: const OutlineInputBorder(),
                label: const Text(
                  'Текст',
                ),
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.tertiary),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(height: 20),
            // if (_selectedImage != null)
            //   SizedBox(
            //     height: MediaQuery.of(context).size.height * 0.25,
            //     child: Image.file(_selectedImage!),
            //   ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image.file(
                _selectedImage ?? widget.note.image,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                _saveEditedNote(widget.note.id);
              },
              icon: const Icon(Icons.system_security_update_rounded),
              label: const Text('Обновить заметку'),
            ),
          ],
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserImagePicker(
            onPickImage: (pickedImage) {
              setState(() {
                _selectedImage = pickedImage;
              });
            },
          ),
          Container(
            height: 60,
            alignment: Alignment.topCenter,
            child: IconButton(
              icon: const Icon(
                Icons.color_lens,
                color: Colors.grey,
              ),
              tooltip: 'Color Palette',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
