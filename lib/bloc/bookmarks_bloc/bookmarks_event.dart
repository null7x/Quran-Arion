part of 'bookmarks_bloc.dart';

abstract class BookmarksEvent extends Equatable {
  const BookmarksEvent();

  @override
  List<Object> get props => [];
}

class LoadBookmarksEvent extends BookmarksEvent {
  const LoadBookmarksEvent();

  @override
  List<Object> get props => [];
}

class AddBookmarkEvent extends BookmarksEvent {
  final int surahNumber;
  final int ayahNumber;
  final String notes;
  
  const AddBookmarkEvent({
    required this.surahNumber,
    required this.ayahNumber,
    this.notes = '',
  });

  @override
  List<Object> get props => [surahNumber, ayahNumber, notes];
}

class RemoveBookmarkEvent extends BookmarksEvent {
  final int id;
  
  const RemoveBookmarkEvent(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateBookmarkEvent extends BookmarksEvent {
  final int id;
  final String notes;
  
  const UpdateBookmarkEvent(this.id, this.notes);

  @override
  List<Object> get props => [id, notes];
}
