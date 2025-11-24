part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserProfileEvent extends UserProfileEvent {
  const LoadUserProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserProfileEvent extends UserProfileEvent {
  final String name;
  final String email;
  
  const UpdateUserProfileEvent({
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [name, email];
}

class UploadProfilePhotoEvent extends UserProfileEvent {
  final String imagePath;
  
  const UploadProfilePhotoEvent(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class ResetStatisticsEvent extends UserProfileEvent {
  const ResetStatisticsEvent();

  @override
  List<Object?> get props => [];
}
