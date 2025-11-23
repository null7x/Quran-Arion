part of 'bookmarks_bloc.dart';

class Bookmark {
  final int id;
  final int surahNumber;
  final String surahName;
  final int ayahNumber;
  final String notes;
  final DateTime dateAdded;

  Bookmark({
    required this.id,
    required this.surahNumber,
    required this.surahName,
    required this.ayahNumber,
    this.notes = '',
    required this.dateAdded,
  });

  Bookmark copyWith({
    int? id,
    int? surahNumber,
    String? surahName,
    int? ayahNumber,
    String? notes,
    DateTime? dateAdded,
  }) {
    return Bookmark(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      surahName: surahName ?? this.surahName,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      notes: notes ?? this.notes,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }
}

class BookmarksState extends Equatable {
  final List<Bookmark> bookmarks;
  final Status status;

  const BookmarksState({
    this.bookmarks = const [],
    this.status = Status.initial,
  });

  BookmarksState copyWith({
    List<Bookmark>? bookmarks,
    Status? status,
  }) {
    return BookmarksState(
      bookmarks: bookmarks ?? this.bookmarks,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [bookmarks, status];
}

enum Status { initial, loading, complete, error }
