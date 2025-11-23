import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(const UserProfileState()) {
    on<LoadUserProfileEvent>(_onLoadUserProfile);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    on<ResetStatisticsEvent>(_onResetStatistics);
  }

  Future<void> _onLoadUserProfile(
      LoadUserProfileEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Default user profile with sample data
      final profile = UserProfile(
        name: 'Muslim User',
        email: 'user@quran-arion.com',
        totalSurahs: 114,
        listeningHours: 24,
        favoriteCount: 8,
        currentStreak: 7,
        joinDate: DateTime.now().subtract(const Duration(days: 30)),
        recentlyPlayed: [1, 2, 3, 4, 5],
      );

      emit(state.copyWith(
        profile: profile,
        status: Status.complete,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onUpdateUserProfile(
      UpdateUserProfileEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final updatedProfile = state.profile?.copyWith(
        name: event.name,
        email: event.email,
      );

      emit(state.copyWith(
        profile: updatedProfile,
        status: Status.complete,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onResetStatistics(
      ResetStatisticsEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final resetProfile = state.profile?.copyWith(
        totalSurahs: 0,
        listeningHours: 0,
        favoriteCount: 0,
        currentStreak: 0,
        recentlyPlayed: [],
      );

      emit(state.copyWith(
        profile: resetProfile,
        status: Status.complete,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
