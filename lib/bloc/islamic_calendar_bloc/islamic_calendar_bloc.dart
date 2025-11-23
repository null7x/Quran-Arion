import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'islamic_calendar_event.dart';
part 'islamic_calendar_state.dart';

class IslamicCalendarBloc extends Bloc<IslamicCalendarEvent, IslamicCalendarState> {
  static const List<String> hijriMonths = [
    'Muharram',
    'Safar',
    'Rabi\' al-awwal',
    'Rabi\' al-thani',
    'Jumada al-awwal',
    'Jumada al-thani',
    'Rajab',
    'Sha\'ban',
    'Ramadan',
    'Shawwal',
    'Dhu al-Qi\'dah',
    'Dhu al-Hijjah',
  ];

  static const List<String> dayNames = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  static const List<IslamicHoliday> islamicHolidays = [
    IslamicHoliday(
      name: 'Islamic New Year',
      month: 1,
      day: 1,
      description: 'Hijri New Year (1st of Muharram)',
    ),
    IslamicHoliday(
      name: 'Ashura',
      month: 1,
      day: 10,
      description: 'Day of remembrance (10th of Muharram)',
    ),
    IslamicHoliday(
      name: 'Mawlid al-Nabi',
      month: 3,
      day: 12,
      description: 'Birthday of Prophet Muhammad (12th of Rabi\' al-awwal)',
    ),
    IslamicHoliday(
      name: 'Laylat al-Isra\'',
      month: 7,
      day: 27,
      description: 'Night of the Journey (27th of Rajab)',
    ),
    IslamicHoliday(
      name: 'Ramadan',
      month: 9,
      day: 1,
      description: 'Start of Ramadan (Sacred month of fasting)',
    ),
    IslamicHoliday(
      name: 'Laylat al-Qadr',
      month: 9,
      day: 27,
      description: 'Night of Power (27th of Ramadan)',
    ),
    IslamicHoliday(
      name: 'Eid al-Fitr',
      month: 10,
      day: 1,
      description: 'Festival of Breaking the Fast',
    ),
    IslamicHoliday(
      name: 'Arafat Day',
      month: 12,
      day: 9,
      description: 'Day of standing at Arafat (Hajj)',
    ),
    IslamicHoliday(
      name: 'Eid al-Adha',
      month: 12,
      day: 10,
      description: 'Festival of Sacrifice',
    ),
  ];

  IslamicCalendarBloc() : super(const IslamicCalendarState()) {
    on<GetIslamicDateEvent>(_onGetIslamicDate);
    on<GetCurrentIslamicDateEvent>(_onGetCurrentIslamicDate);
  }

  Future<void> _onGetIslamicDate(
      GetIslamicDateEvent event, Emitter<IslamicCalendarState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final islamicDate = _convertToIslamic(event.gregorianDate);
      final upcomingHolidays = _getUpcomingHolidays(islamicDate);

      emit(state.copyWith(
        islamicDate: islamicDate,
        gregorianDate: event.gregorianDate,
        holidays: upcomingHolidays,
        status: Status.complete,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onGetCurrentIslamicDate(
      GetCurrentIslamicDateEvent event, Emitter<IslamicCalendarState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final now = DateTime.now();
      final islamicDate = _convertToIslamic(now);
      final upcomingHolidays = _getUpcomingHolidays(islamicDate);

      emit(state.copyWith(
        islamicDate: islamicDate,
        gregorianDate: now,
        holidays: upcomingHolidays,
        status: Status.complete,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  IslamicDate _convertToIslamic(DateTime gregorianDate) {
    // Approximation algorithm for Gregorian to Hijri conversion
    int gy = gregorianDate.year;
    int gm = gregorianDate.month;
    int gd = gregorianDate.day;

    int jd = (1461 * (gy + 4800 + (gm - 14) ~/ 12)) ~/ 4 +
        (367 * (gm - 2 - 12 * (((gm - 14) ~/ 12)))) ~/ 12 -
        (3 * ((gy + 4900 + (gm - 14) ~/ 12) ~/ 100)) ~/ 4 +
        gd -
        32045;

    int l = jd + 1948440 + 386;
    int n = (4 * l) ~/ 146097;
    l = l - (146097 * n + 3) ~/ 4;
    int i = (4000 * (l + 1)) ~/ 1461001;
    l = l - (1461 * i) ~/ 4 + 31;
    int j = (80 * l) ~/ 2447;
    int d = l - (2447 * j) ~/ 80;
    l = j ~/ 11;
    int m = j + 2 - 12 * l;
    int y = 100 * (n - 49) + i + l;

    return IslamicDate(
      day: d,
      month: m,
      year: y,
      monthName: hijriMonths[m - 1],
      dayName: dayNames[gregorianDate.weekday % 7],
    );
  }

  List<IslamicHoliday> _getUpcomingHolidays(IslamicDate currentDate) {
    return islamicHolidays
        .where((holiday) =>
            holiday.month >= currentDate.month ||
            (holiday.month == currentDate.month && holiday.day >= currentDate.day))
        .toList();
  }
}
