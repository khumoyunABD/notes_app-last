import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Note {
  Note({
    required this.title,
    required this.image,
    required this.description,
    //this.noteColor = 'red',
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String title;
  final File image;
  final String description;
  //String noteColor;
}
