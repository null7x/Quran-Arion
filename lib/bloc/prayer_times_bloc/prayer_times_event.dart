part of 'prayer_times_bloc.dart';

abstract class PrayerTimesEvent extends Equatable {
  const PrayerTimesEvent();

  @override
  List<Object> get props => [];
}

class GetPrayerTimesEvent extends PrayerTimesEvent {
  final double latitude;
  final double longitude;
  
  const GetPrayerTimesEvent(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}

class UpdatePrayerTimesEvent extends PrayerTimesEvent {
  const UpdatePrayerTimesEvent();

  @override
  List<Object> get props => [];
}
