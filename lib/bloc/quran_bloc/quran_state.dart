part of 'quran_bloc.dart';

class QuranState extends Equatable {
  final List<String> quranBooks;
  final String? selectedBook;
  final int? selectedSurahNumber;
  final int? playingSurahNumber;
  final String? playingSurahName;
  final bool isPlaying;
  final Status quranStatus;

  const QuranState({
    this.quranBooks = const [],
    this.selectedBook,
    this.selectedSurahNumber,
    this.playingSurahNumber,
    this.playingSurahName,
    this.isPlaying = false,
    this.quranStatus = Status.initial,
  });

  QuranState copyWith({
    List<String>? quranBooks,
    String? selectedBook,
    int? selectedSurahNumber,
    int? playingSurahNumber,
    String? playingSurahName,
    bool? isPlaying,
    Status? quranStatus,
  }) {
    return QuranState(
      quranBooks: quranBooks ?? this.quranBooks,
      selectedBook: selectedBook ?? this.selectedBook,
      selectedSurahNumber: selectedSurahNumber ?? this.selectedSurahNumber,
      playingSurahNumber: playingSurahNumber ?? this.playingSurahNumber,
      playingSurahName: playingSurahName ?? this.playingSurahName,
      isPlaying: isPlaying ?? this.isPlaying,
      quranStatus: quranStatus ?? this.quranStatus,
    );
  }

  @override
  List<Object?> get props => [
    quranBooks,
    selectedBook,
    selectedSurahNumber,
    playingSurahNumber,
    playingSurahName,
    isPlaying,
    quranStatus
  ];
}

enum Status { initial, loading, complete, error }
