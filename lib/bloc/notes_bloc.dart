import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/note.dart';
import 'package:notes/repository/notes_rep.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc({
    required NotesRepository notesRepository,
  })  : _notesRepository = notesRepository,
        super(const NotesState()) {
    on<NotesSubscriptionRequested>(_onSubscriptionRequested);
    on<NoteSaved>(_onSaved);
    on<NoteDeleted>(_onDeleted);
  }

  final NotesRepository _notesRepository;

  Future<void> _onSubscriptionRequested(
    NotesSubscriptionRequested event,
    Emitter<NotesState> emit,
  ) async {
    emit(state.copyWith(status: () => NotesStatus.loading));

    await emit.forEach<List<Note>>(_notesRepository.getNotesStream(),
        onData: (newNotes) {
      return state.copyWith(
        status: () => NotesStatus.success,
        notes: () => newNotes,
      );
    }, onError: (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());

      return state.copyWith(
        status: () => NotesStatus.failure,
      );
    });
  }

  Future<void> _onSaved(
    NoteSaved event,
    Emitter<NotesState> emit,
  ) async {
    await _notesRepository.saveNote(event.note, event.index);
  }

  Future<void> _onDeleted(
    NoteDeleted event,
    Emitter<NotesState> emit,
  ) async {
    await _notesRepository.deleteNote(event.index);
  }
}
