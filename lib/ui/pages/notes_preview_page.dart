import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/bloc/notes_bloc.dart';
import 'package:notes/models/note.dart';
import 'package:notes/ui/pages/note_redact_page.dart';
import 'package:notes/ui/widgets/create_note_dialog.dart';
import 'package:notes/ui/widgets/note_card.dart';

class NotesPreviewPage extends StatelessWidget {
  const NotesPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки'),
      ),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          switch (state.status) {
            case NotesStatus.initial:
              return const Center(child: Text('Инициализация'));
            case NotesStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case NotesStatus.success:
              return Column(
                children: [
                  Expanded(
                    child: state.notes.isNotEmpty
                        ? ListView(
                            children: [
                              for (int i = 0; i < state.notes.length; i++)
                                NoteCard(
                                  note: state.notes[i],
                                  deleteCallback: () {
                                    context
                                        .read<NotesBloc>()
                                        .add(NoteDeleted(i));
                                  },
                                  editCallback: () {
                                    Navigator.of(context).push(
                                        NoteRedactPage.route(
                                            editingNote: state.notes[i],
                                            index: i));
                                  },
                                )
                            ],
                          )
                        : const Center(child: Text('У вас нет заметок')),
                  ),
                  TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: ((_) => CreateNoteDialog(
                                submitCallback: ((title, description) {
                                  context.read<NotesBloc>().add(NoteSaved(Note(
                                      title: title, description: description)));
                                }),
                              )),
                        );
                      },
                      child: const Text('Добавить заметку'))
                ],
              );
            case NotesStatus.failure:
              return const Center(child: Text('Ошибка'));
          }
        },
      ),
    );
  }
}
