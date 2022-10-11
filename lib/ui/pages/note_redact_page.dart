import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/bloc/notes_bloc.dart';
import 'package:notes/models/note.dart';

class NoteRedactPage extends StatefulWidget {
  final int index;
  final Note note;

  const NoteRedactPage({Key? key, required this.note, required this.index})
      : super(key: key);

  static Route<void> route({required Note editingNote, required int index}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => NoteRedactPage(
        note: editingNote,
        index: index,
      ),
    );
  }

  @override
  State<NoteRedactPage> createState() => _NoteRedactPageState();
}

class _NoteRedactPageState extends State<NoteRedactPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController()..text = widget.note.title;
    _descriptionController = TextEditingController()
      ..text = widget.note.description;
    _imagePath = widget.note.imagePath;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto({bool isCamera = false}) async {
    try {
      final XFile? file = await _picker.pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);

      _imagePath = file!.path;
      setState(() {});
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  Future<void> _deletePhoto() async {
    try {
      final File file = File(_imagePath!);

      await file.delete();
      _imagePath = null;
      setState(() {});
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редактирование')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Column(children: [
          Expanded(
              child: Column(
            children: [
              Expanded(
                  child: _imagePath == null
                      ? Container(
                          color: Colors.grey,
                        )
                      : Image.file(File(_imagePath!))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () => _pickPhoto(),
                      child: const Text('галерея')),
                  TextButton(
                    onPressed: () => _pickPhoto(isCamera: true),
                    child: const Text('камера'),
                  ),
                  if (_imagePath != null)
                    TextButton(
                        onPressed: _deletePhoto, child: const Text('удалить')),
                ],
              )
            ],
          )),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: _titleController,
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: _descriptionController,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Назад')),
              TextButton(
                onPressed: () {
                  if (_descriptionController.text.isEmpty ||
                      _titleController.text.isEmpty) {
                    return;
                  }
                  context.read<NotesBloc>().add(NoteSaved(
                      Note(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          imagePath: _imagePath),
                      widget.index));
                  Navigator.of(context).pop();
                },
                child: const Text('Сохранить'),
              )
            ],
          )
        ]),
      ),
    );
  }
}
