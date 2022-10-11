import 'package:equatable/equatable.dart';
import 'package:notes/models/note_hive.dart';

class Note extends Equatable {
  final String title;
  final String description;
  final String? imagePath;

  const Note({
    required this.title,
    required this.description,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        imagePath,
      ];

  Note copyWith(
      {String? title,
      String? description,
      String? imagePath,
      bool setPathToNull = false}) {
    return Note(
        title: title ?? this.title,
        description: description ?? this.description,
        imagePath: setPathToNull ? null : imagePath ?? this.imagePath);
  }

  NoteHive toNoteHive() {
    return NoteHive(
      description: description,
      title: title,
      imagePath: imagePath,
    );
  }
}
