import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notes/logic/note_controller.dart';

import 'package:notes/widgets/image_picker.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _selectedImage;

  _saveNote() {
    final enteredTitle = _titleController.text;
    final enteredDescription = _descriptionController.text;
    //File? image;

    if (enteredTitle.isEmpty || enteredDescription.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Заполните все поля!'),
          duration: Duration(seconds: 3),
        ),
      );
    }
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Добавьте картинку!'),
          duration: Duration(seconds: 3),
        ),
      );
    }

    Get.find<NoteController>()
        .addNote(enteredTitle, _selectedImage!, enteredDescription);
    Get.find<NoteController>().loadNotes();

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
        title: const Text('Добавить новую заметку'),
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
              decoration: const InputDecoration(labelText: 'Заголовок'),
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
                hintText: 'Пишите здесь',
                hintStyle: const TextStyle(color: Colors.grey),
                hintMaxLines: 6,
                contentPadding: const EdgeInsets.all(20),
                border: const OutlineInputBorder(),
                label: const Text(
                  'Текст',
                ),
                labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedImage != null)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Image.file(_selectedImage!),
              ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _saveNote,
              icon: const Icon(Icons.add),
              label: const Text('Добавить заметку'),
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
