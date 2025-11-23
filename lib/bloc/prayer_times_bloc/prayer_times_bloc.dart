import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'prayer_times_event.dart';
part 'prayer_times_state.dart';

class PrayerTimesBloc extends Bloc<PrayerTimesEvent, PrayerTimesState> {
  PrayerTimesBloc() : super(const PrayerTimesState()) {
    on<GetPrayerTimesEvent>(_onGetPrayerTimes);
    on<UpdatePrayerTimesEvent>(_onUpdatePrayerTimes);
  }

  Future<void> _onGetPrayerTimes(
      GetPrayerTimesEvent event, Emitter<PrayerTimesState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      // Пример времени молитвы для Москвы
      // В реальном приложении это должно рассчитываться по координатам
      final prayerTimes = [
        PrayerTime(
          name: 'Fajr',
          time: '05:45',
          arabicName: 'الفجر',
        ),
        PrayerTime(
          name: 'Dhuhr',
          time: '12:35',
          arabicName: 'الظهر',
        ),
        PrayerTime(
          name: 'Asr',
          time: '15:45',
          arabicName: 'العصر',
        ),
        PrayerTime(
          name: 'Maghrib',
          time: '18:55',
          arabicName: 'المغرب',
        ),
        PrayerTime(
          name: 'Isha',
          time: '20:30',
          arabicName: 'العشاء',
        ),
      ];

      emit(state.copyWith(
        prayerTimes: prayerTimes,
        nextPrayer: 'Dhuhr',
        timeUntilNextPrayer: '02:15',
        status: Status.complete,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onUpdatePrayerTimes(
      UpdatePrayerTimesEvent event, Emitter<PrayerTimesState> emit) async {
    // Обновление времени молитвы каждую минуту
    emit(state.copyWith(status: Status.loading));
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: Status.complete));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
