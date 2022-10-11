part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class NotesSubscriptionRequested extends NotesEvent {
  const NotesSubscriptionRequested();
  @override
  List<Object?> get props => [];
}

class NoteSaved extends NotesEvent {
  final Note note;
  final int? index;
  const NoteSaved(this.note, [this.index]);

  @override
  List<Object?> get props => [index, note];
}

class NoteDeleted extends NotesEvent {
  final int index;
  const NoteDeleted(this.index);

  @override
  List<Object?> get props => [
        index,
      ];
}
