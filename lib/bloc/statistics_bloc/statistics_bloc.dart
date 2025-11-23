import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc() : super(const StatisticsState()) {
    on<LoadStatisticsEvent>(_onLoadStatistics);
    on<RecordSurahListenEvent>(_onRecordSurahListen);
    on<IncrementDailyStreakEvent>(_onIncrementDailyStreak);
  }

  Future<void> _onLoadStatistics(
      LoadStatisticsEvent event, Emitter<StatisticsState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // Load from local storage
      emit(state.copyWith(status: Status.complete));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onRecordSurahListen(
      RecordSurahListenEvent event, Emitter<StatisticsState> emit) async {
    try {
      final stats = state.statistics;
      final updatedPlayCounts = Map<int, int>.from(stats.surahPlayCounts);
      updatedPlayCounts[event.surahNumber] =
          (updatedPlayCounts[event.surahNumber] ?? 0) + 1;

      final totalHours = stats.totalListeningHours +
          (event.listeningDuration ~/ 60);
      
      final updated = stats.copyWith(
        totalSurahsListened: stats.totalSurahsListened + 1,
        totalListeningHours: totalHours,
        lastListenDate: DateTime.now(),
        surahPlayCounts: updatedPlayCounts,
      );

      emit(state.copyWith(statistics: updated));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onIncrementDailyStreak(
      IncrementDailyStreakEvent event, Emitter<StatisticsState> emit) async {
    try {
      final stats = state.statistics;
      final now = DateTime.now();
      final lastDate = stats.lastListenDate;
      
      int newStreak = stats.currentStreak;
      if (now.difference(lastDate).inDays == 1) {
        newStreak++;
      } else if (now.difference(lastDate).inDays == 0) {
        // Same day, no change
      } else {
        newStreak = 1;
      }

      final longestStreak = newStreak > stats.longestStreak
          ? newStreak
          : stats.longestStreak;

      final updated = stats.copyWith(
        currentStreak: newStreak,
        longestStreak: longestStreak,
        lastListenDate: now,
      );

      emit(state.copyWith(statistics: updated));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
