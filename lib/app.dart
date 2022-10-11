import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes/models/note_hive.dart';
import 'package:notes/repository/notes_rep.dart';

import 'package:notes/ui/pages/notes_preview_page.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/notes_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory _appDocDir = await getApplicationDocumentsDirectory();

  Hive
    ..init(_appDocDir.path)
    ..registerAdapter(NoteHiveAdapter());

  runApp(BlocProvider(
    create: (context) {
      return NotesBloc(notesRepository: NotesRepository(boxName: 'notes'))
        ..add(const NotesSubscriptionRequested());
    },
    child: const MaterialApp(
      home: NotesPreviewPage(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
