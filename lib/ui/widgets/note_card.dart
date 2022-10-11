import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  final void Function() deleteCallback;
  final void Function() editCallback;

  const NoteCard(
      {Key? key,
      required this.note,
      required this.deleteCallback,
      required this.editCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxHeight: 50, minHeight: 50, minWidth: 50, maxWidth: 50),
                child: note.imagePath == null
                    ? const Center(child: Icon(Icons.person))
                    : Image.file(File(note.imagePath!)),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(note.description),
              ],
            )),
            IconButton(onPressed: editCallback, icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: deleteCallback, icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
