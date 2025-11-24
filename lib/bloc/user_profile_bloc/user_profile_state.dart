part of 'user_profile_bloc.dart';

class UserProfile {
  final String name;
  final String email;
  final int totalSurahs;
  final int listeningHours;
  final int favoriteCount;
  final int currentStreak;
  final DateTime joinDate;
  final List<int> recentlyPlayed;
  final String? photoPath;

  UserProfile({
    required this.name,
    required this.email,
    required this.totalSurahs,
    required this.listeningHours,
    required this.favoriteCount,
    required this.currentStreak,
    required this.joinDate,
    required this.recentlyPlayed,
    this.photoPath,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    int? totalSurahs,
    int? listeningHours,
    int? favoriteCount,
    int? currentStreak,
    DateTime? joinDate,
    List<int>? recentlyPlayed,
    String? photoPath,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      totalSurahs: totalSurahs ?? this.totalSurahs,
      listeningHours: listeningHours ?? this.listeningHours,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      currentStreak: currentStreak ?? this.currentStreak,
      joinDate: joinDate ?? this.joinDate,
      recentlyPlayed: recentlyPlayed ?? this.recentlyPlayed,
      photoPath: photoPath ?? this.photoPath,
    );
  }
}

class UserProfileState extends Equatable {
  final UserProfile? profile;
  final Status status;

  const UserProfileState({
    this.profile,
    this.status = Status.initial,
  });

  UserProfileState copyWith({
    UserProfile? profile,
    Status? status,
  }) {
    return UserProfileState(
      profile: profile ?? this.profile,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [profile, status];
}

enum Status { initial, loading, complete, error }
