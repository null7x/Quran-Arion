part of 'islamic_calendar_bloc.dart';

class IslamicDate {
  final int day;
  final int month;
  final int year;
  final String monthName;
  final String dayName;

  IslamicDate({
    required this.day,
    required this.month,
    required this.year,
    required this.monthName,
    required this.dayName,
  });

  @override
  String toString() => '$day ${monthName.split('-')[0]} $year AH';
}

class IslamicCalendarState extends Equatable {
  final IslamicDate? islamicDate;
  final DateTime? gregorianDate;
  final Status status;
  final List<IslamicHoliday> holidays;

  const IslamicCalendarState({
    this.islamicDate,
    this.gregorianDate,
    this.status = Status.initial,
    this.holidays = const [],
  });

  IslamicCalendarState copyWith({
    IslamicDate? islamicDate,
    DateTime? gregorianDate,
    Status? status,
    List<IslamicHoliday>? holidays,
  }) {
    return IslamicCalendarState(
      islamicDate: islamicDate ?? this.islamicDate,
      gregorianDate: gregorianDate ?? this.gregorianDate,
      status: status ?? this.status,
      holidays: holidays ?? this.holidays,
    );
  }

  @override
  List<Object?> get props => [islamicDate, gregorianDate, status, holidays];
}

class IslamicHoliday {
  final String name;
  final int month;
  final int day;
  final String description;

  IslamicHoliday({
    required this.name,
    required this.month,
    required this.day,
    required this.description,
  });
}

enum Status { initial, loading, complete, error }
