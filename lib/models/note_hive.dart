import 'package:hive/hive.dart';
import 'package:notes/models/note.dart';

part 'note_hive.g.dart';

@HiveType(typeId: 0)
class NoteHive extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  String? imagePath;

  NoteHive({
    required this.description,
    required this.title,
    this.imagePath,
  });

  Note toNote() {
    return Note(
      title: title,
      description: description,
      imagePath: imagePath,
    );
  }
}
