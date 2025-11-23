import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bookmarks_event.dart';
part 'bookmarks_state.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  int _nextId = 1;

  BookmarksBloc() : super(const BookmarksState()) {
    on<LoadBookmarksEvent>(_onLoadBookmarks);
    on<AddBookmarkEvent>(_onAddBookmark);
    on<RemoveBookmarkEvent>(_onRemoveBookmark);
    on<UpdateBookmarkEvent>(_onUpdateBookmark);
  }

  final List<String> surahNames = [
    'Al-Fatiha', 'Al-Baqarah', 'Al-Imran', 'An-Nisa', 'Al-Ma\'idah',
    'Al-An\'am', 'Al-A\'raf', 'Al-Anfal', 'At-Taubah', 'Yunus',
    'Hud', 'Yusuf', 'Ar-Ra\'d', 'Ibrahim', 'Al-Hijr',
    'An-Nahl', 'Al-Isra', 'Al-Kahf', 'Maryam', 'Taha',
    'Al-Anbiya', 'Al-Hajj', 'Al-Mu\'minun', 'An-Nur', 'Al-Furqan',
    'Ash-Shu\'ara', 'An-Naml', 'Al-Qasas', 'Al-Ankabut', 'Ar-Rum',
  ];

  Future<void> _onLoadBookmarks(
      LoadBookmarksEvent event, Emitter<BookmarksState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // Load from local storage
      emit(state.copyWith(status: Status.complete));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onAddBookmark(
      AddBookmarkEvent event, Emitter<BookmarksState> emit) async {
    try {
      final surahName = event.surahNumber <= surahNames.length
          ? surahNames[event.surahNumber - 1]
          : 'Unknown';

      final newBookmark = Bookmark(
        id: _nextId++,
        surahNumber: event.surahNumber,
        surahName: surahName,
        ayahNumber: event.ayahNumber,
        notes: event.notes,
        dateAdded: DateTime.now(),
      );

      final updatedBookmarks = [...state.bookmarks, newBookmark];
      emit(state.copyWith(bookmarks: updatedBookmarks));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onRemoveBookmark(
      RemoveBookmarkEvent event, Emitter<BookmarksState> emit) async {
    try {
      final updatedBookmarks = state.bookmarks
          .where((bookmark) => bookmark.id != event.id)
          .toList();
      emit(state.copyWith(bookmarks: updatedBookmarks));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onUpdateBookmark(
      UpdateBookmarkEvent event, Emitter<BookmarksState> emit) async {
    try {
      final updatedBookmarks = state.bookmarks.map((bookmark) {
        return bookmark.id == event.id
            ? bookmark.copyWith(notes: event.notes)
            : bookmark;
      }).toList();
      emit(state.copyWith(bookmarks: updatedBookmarks));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
