part of 'quran_bloc.dart';

abstract class QuranEvent extends Equatable {
  const QuranEvent();

  @override
  List<Object> get props => [];
}

class GetQuranBooksEvent extends QuranEvent {
  const GetQuranBooksEvent();

  @override
  List<Object> get props => [];
}

class SelectQuranBookEvent extends QuranEvent {
  final String bookName;
  final int surahNumber;
  const SelectQuranBookEvent(this.bookName, this.surahNumber);

  @override
  List<Object> get props => [bookName, surahNumber];
}

class PlayQuranSurahEvent extends QuranEvent {
  final int surahNumber;
  final String surahName;
  const PlayQuranSurahEvent(this.surahNumber, this.surahName);

  @override
  List<Object> get props => [surahNumber, surahName];
}

class StopQuranPlaybackEvent extends QuranEvent {
  const StopQuranPlaybackEvent();

  @override
  List<Object> get props => [];
}
