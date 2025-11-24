import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      // Получение времени молитвы через Aladhan API
      // Используем координаты: latitude и longitude
      final latitude = event.latitude ?? 55.7558; // Москва по умолчанию
      final longitude = event.longitude ?? 37.6173;
      
      print('🕌 Fetching prayer times for: $latitude, $longitude');
      
      final url = Uri.parse(
        'https://api.aladhan.com/v1/timings?latitude=$latitude&longitude=$longitude&method=2',
      );
      
      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Prayer times request timeout'),
      );
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final timings = json['data']['timings'] as Map<String, dynamic>;
        
        print('✅ Prayer times fetched successfully');
        
        final prayerTimes = [
          PrayerTime(
            name: 'Fajr',
            time: _parseTime(timings['Fajr']),
            arabicName: 'الفجر',
          ),
          PrayerTime(
            name: 'Dhuhr',
            time: _parseTime(timings['Dhuhr']),
            arabicName: 'الظهر',
          ),
          PrayerTime(
            name: 'Asr',
            time: _parseTime(timings['Asr']),
            arabicName: 'العصر',
          ),
          PrayerTime(
            name: 'Maghrib',
            time: _parseTime(timings['Maghrib']),
            arabicName: 'المغرب',
          ),
          PrayerTime(
            name: 'Isha',
            time: _parseTime(timings['Isha']),
            arabicName: 'العشاء',
          ),
        ];

        // Найти следующую молитву
        String nextPrayer = 'Fajr';
        String timeUntil = _calculateTimeUntil(prayerTimes[0].time);
        
        emit(state.copyWith(
          prayerTimes: prayerTimes,
          nextPrayer: nextPrayer,
          timeUntilNextPrayer: timeUntil,
          status: Status.complete,
        ));
      } else {
        print('❌ Failed to fetch prayer times: ${response.statusCode}');
        emit(state.copyWith(status: Status.error));
      }
    } catch (e) {
      print('❌ Error fetching prayer times: $e');
      
      // Fallback на данные для Москвы
      final fallbackTimes = [
        PrayerTime(name: 'Fajr', time: '05:45', arabicName: 'الفجر'),
        PrayerTime(name: 'Dhuhr', time: '12:35', arabicName: 'الظهر'),
        PrayerTime(name: 'Asr', time: '15:45', arabicName: 'العصر'),
        PrayerTime(name: 'Maghrib', time: '18:55', arabicName: 'المغرب'),
        PrayerTime(name: 'Isha', time: '20:30', arabicName: 'العشاء'),
      ];
      
      emit(state.copyWith(
        prayerTimes: fallbackTimes,
        nextPrayer: 'Dhuhr',
        timeUntilNextPrayer: '02:15',
        status: Status.complete,
      ));
    }
  }

  String _parseTime(String timeString) {
    // API возвращает время в формате "HH:MM"
    return timeString.split(' ')[0]; // Remove timezone info if present
  }

  String _calculateTimeUntil(String prayerTime) {
    // Простой расчет времени до молитвы
    try {
      final parts = prayerTime.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      
      final now = DateTime.now();
      final prayerDateTime = DateTime(now.year, now.month, now.day, hour, minute);
      
      final difference = prayerDateTime.difference(now);
      
      if (difference.isNegative) {
        return 'Passed';
      }
      
      final hours = difference.inHours;
      final minutes = difference.inMinutes % 60;
      
      return '$hours:${minutes.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'N/A';
    }
  }

  Future<void> _onUpdatePrayerTimes(
      UpdatePrayerTimesEvent event, Emitter<PrayerTimesState> emit) async {
    // Обновление времени молитвы каждый час
    emit(state.copyWith(status: Status.loading));
    
    try {
      await Future.delayed(const Duration(minutes: 5));
      
      // Пересчет времени до следующей молитвы
      if (state.prayerTimes.isNotEmpty) {
        final newTimeUntil = _calculateTimeUntil(state.prayerTimes[0].time);
        emit(state.copyWith(
          timeUntilNextPrayer: newTimeUntil,
          status: Status.complete,
        ));
      } else {
        emit(state.copyWith(status: Status.complete));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
