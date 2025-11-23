part of 'quran_bloc.dart';

class QuranState extends Equatable {
  final List<String> quranBooks;
  final String? selectedBook;
  final Status quranStatus;

  const QuranState({
    this.quranBooks = const [],
    this.selectedBook,
    this.quranStatus = Status.initial,
  });

  QuranState copyWith({
    List<String>? quranBooks,
    String? selectedBook,
    Status? quranStatus,
  }) {
    return QuranState(
      quranBooks: quranBooks ?? this.quranBooks,
      selectedBook: selectedBook ?? this.selectedBook,
      quranStatus: quranStatus ?? this.quranStatus,
    );
  }

  @override
  List<Object?> get props => [quranBooks, selectedBook, quranStatus];
}

enum Status { initial, loading, complete, error }
