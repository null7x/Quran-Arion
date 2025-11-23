part of 'qibla_bloc.dart';

class QiblaState extends Equatable {
  final double heading;
  final double qiblaDirection;
  final bool isCompassAvailable;
  final String? errorMessage;
  final QiblaStatus status;

  const QiblaState({
    this.heading = 0.0,
    this.qiblaDirection = 0.0,
    this.isCompassAvailable = false,
    this.errorMessage,
    this.status = QiblaStatus.initial,
  });

  QiblaState copyWith({
    double? heading,
    double? qiblaDirection,
    bool? isCompassAvailable,
    String? errorMessage,
    QiblaStatus? status,
  }) {
    return QiblaState(
      heading: heading ?? this.heading,
      qiblaDirection: qiblaDirection ?? this.qiblaDirection,
      isCompassAvailable: isCompassAvailable ?? this.isCompassAvailable,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    heading,
    qiblaDirection,
    isCompassAvailable,
    errorMessage,
    status,
  ];
}

enum QiblaStatus { initial, loading, success, error }
