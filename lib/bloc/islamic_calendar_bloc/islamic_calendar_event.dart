part of 'islamic_calendar_bloc.dart';

abstract class IslamicCalendarEvent extends Equatable {
  const IslamicCalendarEvent();

  @override
  List<Object> get props => [];
}

class GetIslamicDateEvent extends IslamicCalendarEvent {
  final DateTime gregorianDate;
  
  const GetIslamicDateEvent(this.gregorianDate);

  @override
  List<Object> get props => [gregorianDate];
}

class GetCurrentIslamicDateEvent extends IslamicCalendarEvent {
  const GetCurrentIslamicDateEvent();

  @override
  List<Object> get props => [];
}
