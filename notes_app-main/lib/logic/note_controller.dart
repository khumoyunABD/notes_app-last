import 'dart:io';

import 'package:get/get.dart';
import 'package:notes/models/note.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'notes.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE client_notes(id TEXT PRIMARY KEY, title TEXT, image TEXT, description TEXT)');
    },
    version: 1,
  );
  return db;
}

class NoteController extends GetxController {
  List<Note> notes = <Note>[];
  String imageUrl =
      'https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734';

  Future<void> loadNotes() async {
    final db = await _getDatabase();
    final data = await db.query('client_notes');
    final notes1 = data
        .map(
          (row) => Note(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            description: row['description'] as String,
          ),
        )
        .toList();

    //not sure about the line below
    notes = notes1;
    update();
  }

  void addNote(String title, File image, String description) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();

    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');
    final newNote = Note(
      title: title,
      image: copiedImage,
      description: description,
    );

    final db = await _getDatabase();

    db.insert('client_notes', {
      'id': newNote.id,
      'title': newNote.title,
      'image': newNote.image.path,
      'description': newNote.description,
    });
    loadNotes();
  }

  Future<void> deleteNote(String id) async {
    final db = await _getDatabase();

    await db.delete('client_notes', where: '$id = ?', whereArgs: [id]);

    loadNotes();
  }
}
