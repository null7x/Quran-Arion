part of 'daily_verse_bloc.dart';

class DailyVerse {
  final int surahNumber;
  final String surahName;
  final int ayahNumber;
  final String arabicText;
  final String englishTranslation;
  final String russianTranslation;
  final String explanation;

  DailyVerse({
    required this.surahNumber,
    required this.surahName,
    required this.ayahNumber,
    required this.arabicText,
    required this.englishTranslation,
    required this.russianTranslation,
    required this.explanation,
  });
}

class DailyVerseState extends Equatable {
  final DailyVerse? verse;
  final Status status;

  const DailyVerseState({
    this.verse,
    this.status = Status.initial,
  });

  DailyVerseState copyWith({
    DailyVerse? verse,
    Status? status,
  }) {
    return DailyVerseState(
      verse: verse ?? this.verse,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [verse, status];
}

enum Status { initial, loading, complete, error }
