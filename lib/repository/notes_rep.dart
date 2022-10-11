import 'dart:async';

import 'package:hive/hive.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note_hive.dart';

class NotesRepository {
  NotesRepository({required String boxName}) {
    _controller = StreamController<List<Note>>.broadcast();
    _init(boxName);
  }

  late final Box<NoteHive> _notesBox;
  late final StreamController<List<Note>> _controller;
  final List<Note> _notes = [];

  Stream<List<Note>> getNotesStream() => _controller.stream;

  Future<void> saveNote(Note note, [int? index]) async {
    final NoteHive noteHive = note.toNoteHive();

    if (index != null) {
      if (note == _notes[index]) {
        return;
      }

      _notes[index] = note;
      await _notesBox.putAt(index, noteHive);
    } else {
      _notes.add(note);
      await _notesBox.add(noteHive);
    }

    _controller.add(List.of(_notes));
  }

  Future<void> deleteNote(int index) async {
    _notes.removeAt(index);
    await _notesBox.deleteAt(index);
    _controller.add(List.of(_notes));
  }

  Future<void> _init(String name) async {
    _notesBox = await Hive.openBox(name);
    List<Note> notes = _notesBox.isEmpty
        ? const []
        : _notesBox.values.map<Note>((n) => n.toNote()).toList();

    _notes.addAll(notes);
    _controller.add(List.of(_notes));
  }
}
