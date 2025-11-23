part of 'daily_verse_bloc.dart';

abstract class DailyVerseEvent extends Equatable {
  const DailyVerseEvent();

  @override
  List<Object> get props => [];
}

class GetDailyVerseEvent extends DailyVerseEvent {
  const GetDailyVerseEvent();

  @override
  List<Object> get props => [];
}

class ShareVerseEvent extends DailyVerseEvent {
  final String verseText;
  
  const ShareVerseEvent(this.verseText);

  @override
  List<Object> get props => [verseText];
}
