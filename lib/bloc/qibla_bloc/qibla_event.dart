part of 'qibla_bloc.dart';

abstract class QiblaEvent extends Equatable {
  const QiblaEvent();

  @override
  List<Object> get props => [];
}

class GetQiblaDirectionEvent extends QiblaEvent {
  const GetQiblaDirectionEvent();

  @override
  List<Object> get props => [];
}

class UpdateQiblaDirectionEvent extends QiblaEvent {
  final double heading;
  final double qiblaDirection;
  
  const UpdateQiblaDirectionEvent(this.heading, this.qiblaDirection);

  @override
  List<Object> get props => [heading, qiblaDirection];
}
