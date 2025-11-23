part of 'prayer_times_bloc.dart';

class PrayerTime {
  final String name;
  final String time;
  final String arabicName;

  PrayerTime({
    required this.name,
    required this.time,
    required this.arabicName,
  });
}

class PrayerTimesState extends Equatable {
  final List<PrayerTime> prayerTimes;
  final String? nextPrayer;
  final String? timeUntilNextPrayer;
  final Status status;

  const PrayerTimesState({
    this.prayerTimes = const [],
    this.nextPrayer,
    this.timeUntilNextPrayer,
    this.status = Status.initial,
  });

  PrayerTimesState copyWith({
    List<PrayerTime>? prayerTimes,
    String? nextPrayer,
    String? timeUntilNextPrayer,
    Status? status,
  }) {
    return PrayerTimesState(
      prayerTimes: prayerTimes ?? this.prayerTimes,
      nextPrayer: nextPrayer ?? this.nextPrayer,
      timeUntilNextPrayer: timeUntilNextPrayer ?? this.timeUntilNextPrayer,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [prayerTimes, nextPrayer, timeUntilNextPrayer, status];
}

enum Status { initial, loading, complete, error }
