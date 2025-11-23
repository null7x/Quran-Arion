part of 'statistics_bloc.dart';

class DailyStatistics {
  final DateTime date;
  final int listeningMinutes;
  final int surahsListened;

  DailyStatistics({
    required this.date,
    required this.listeningMinutes,
    required this.surahsListened,
  });
}

class AppStatistics {
  final int totalSurahsListened;
  final int totalListeningHours;
  final int currentStreak;
  final int longestStreak;
  final DateTime lastListenDate;
  final List<DailyStatistics> dailyStats;
  final Map<int, int> surahPlayCounts;

  AppStatistics({
    this.totalSurahsListened = 0,
    this.totalListeningHours = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    required this.lastListenDate,
    this.dailyStats = const [],
    this.surahPlayCounts = const {},
  });

  AppStatistics copyWith({
    int? totalSurahsListened,
    int? totalListeningHours,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastListenDate,
    List<DailyStatistics>? dailyStats,
    Map<int, int>? surahPlayCounts,
  }) {
    return AppStatistics(
      totalSurahsListened: totalSurahsListened ?? this.totalSurahsListened,
      totalListeningHours: totalListeningHours ?? this.totalListeningHours,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastListenDate: lastListenDate ?? this.lastListenDate,
      dailyStats: dailyStats ?? this.dailyStats,
      surahPlayCounts: surahPlayCounts ?? this.surahPlayCounts,
    );
  }
}

class StatisticsState extends Equatable {
  final AppStatistics statistics;
  final Status status;

  const StatisticsState({
    AppStatistics? statistics,
    this.status = Status.initial,
  }) : statistics = statistics ?? AppStatistics(lastListenDate: DateTime.now());

  StatisticsState copyWith({
    AppStatistics? statistics,
    Status? status,
  }) {
    return StatisticsState(
      statistics: statistics ?? this.statistics,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [statistics, status];
}

enum Status { initial, loading, complete, error }
