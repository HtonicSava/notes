part of 'notes_bloc.dart';

enum NotesStatus { initial, loading, success, failure }

extension NotesStatusX on NotesStatus {
  bool get isInitial => this == NotesStatus.initial;
  bool get isLoading => this == NotesStatus.loading;
  bool get isSuccess => this == NotesStatus.success;
  bool get isFailure => this == NotesStatus.failure;
}

class NotesState extends Equatable {
  final NotesStatus status;
  final List<Note> notes;

  const NotesState({this.status = NotesStatus.initial, this.notes = const []});

  @override
  List<Object?> get props => [status, notes];

  NotesState copyWith(
      {NotesStatus Function()? status, List<Note> Function()? notes}) {
    return NotesState(
        status: status != null ? status() : this.status,
        notes: notes != null ? notes() : this.notes);
  }
}
