part of 'statistics_bloc.dart';

abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();

  @override
  List<Object> get props => [];
}

class LoadStatisticsEvent extends StatisticsEvent {
  const LoadStatisticsEvent();

  @override
  List<Object> get props => [];
}

class RecordSurahListenEvent extends StatisticsEvent {
  final int surahNumber;
  final int listeningDuration;
  
  const RecordSurahListenEvent(this.surahNumber, this.listeningDuration);

  @override
  List<Object> get props => [surahNumber, listeningDuration];
}

class IncrementDailyStreakEvent extends StatisticsEvent {
  const IncrementDailyStreakEvent();

  @override
  List<Object> get props => [];
}
