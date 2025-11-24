import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

part 'qibla_event.dart';
part 'qibla_state.dart';

class QiblaBloc extends Bloc<QiblaEvent, QiblaState> {
  QiblaBloc() : super(const QiblaState()) {
    on<GetQiblaDirectionEvent>(_onGetQiblaDirection);
    on<UpdateQiblaDirectionEvent>(_onUpdateQiblaDirection);
  }

  // Координаты Каабы в Мекке
  static const double kaabaLatitude = 21.4225;
  static const double kaabaLongitude = 39.8261;

  // Пример координат (Москва). В реальном приложении нужно получить текущую локацию
  double userLatitude = 55.7558;
  double userLongitude = 37.6173;

  Future<void> _onGetQiblaDirection(
      GetQiblaDirectionEvent event, Emitter<QiblaState> emit) async {
    emit(state.copyWith(status: QiblaStatus.loading));
    
    try {
      // Получаем текущую локацию пользователя
      try {
        final Position? position = await _getLocationWithTimeout();
        
        if (position != null) {
          userLatitude = position.latitude;
          userLongitude = position.longitude;
          print('📍 Got user location: $userLatitude, $userLongitude');
        } else {
          print('⚠️ Using default location: Moscow');
        }
      } catch (e) {
        print('⚠️ Using default location: Moscow. Error: $e');
      }

      // Рассчитываем направление на Каабу
      double qiblaDirection = _calculateQiblaDirection(
        userLatitude,
        userLongitude,
        kaabaLatitude,
        kaabaLongitude,
      );

      print('🕌 Qibla direction calculated: $qiblaDirection°');

      emit(state.copyWith(
        qiblaDirection: qiblaDirection,
        isCompassAvailable: true,
        status: QiblaStatus.success,
      ));
    } catch (e) {
      print('❌ Error in _onGetQiblaDirection: $e');
      emit(state.copyWith(
        status: QiblaStatus.error,
        errorMessage: 'Failed to get Qibla direction: $e',
      ));
    }
  }

  Future<void> _onUpdateQiblaDirection(
      UpdateQiblaDirectionEvent event, Emitter<QiblaState> emit) async {
    emit(state.copyWith(
      heading: event.heading,
      qiblaDirection: event.qiblaDirection,
    ));
  }

  // Вычисление направления на основе формулы гаверсинуса
  double _calculateQiblaDirection(
    double userLat,
    double userLon,
    double kaabaLat,
    double kaabaLon,
  ) {
    double latDiff = (kaabaLat - userLat) * (pi / 180);
    double lonDiff = (kaabaLon - userLon) * (pi / 180);

    double userLatRad = userLat * (pi / 180);
    double kaabaLatRad = kaabaLat * (pi / 180);

    double y = sin(lonDiff) * cos(kaabaLatRad);
    double x = cos(userLatRad) * sin(kaabaLatRad) -
        sin(userLatRad) * cos(kaabaLatRad) * cos(lonDiff);

    double bearing = atan2(y, x) * (180 / pi);
    bearing = (bearing + 360) % 360;

    return bearing;
  }

  Future<Position?> _getLocationWithTimeout() async {
    try {
      return await Geolocator.getCurrentPosition()
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      print('❌ Error getting location: $e');
      return null;
    }
  }
}
