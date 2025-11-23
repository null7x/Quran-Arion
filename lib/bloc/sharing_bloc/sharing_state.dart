enum SharingStatus { initial, loading, success, error }

class SharedVerse {
  final int surahNumber;
  final int ayahNumber;
  final String arabicText;
  final String translation;
  final int likes;
  final List<String> comments;
  final DateTime sharedAt;
  final String sharedBy;

  SharedVerse({
    required this.surahNumber,
    required this.ayahNumber,
    required this.arabicText,
    required this.translation,
    required this.likes,
    required this.comments,
    required this.sharedAt,
    required this.sharedBy,
  });

  SharedVerse copyWith({
    int? surahNumber,
    int? ayahNumber,
    String? arabicText,
    String? translation,
    int? likes,
    List<String>? comments,
    DateTime? sharedAt,
    String? sharedBy,
  }) {
    return SharedVerse(
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      arabicText: arabicText ?? this.arabicText,
      translation: translation ?? this.translation,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      sharedAt: sharedAt ?? this.sharedAt,
      sharedBy: sharedBy ?? this.sharedBy,
    );
  }
}

class CommunityUser {
  final String userId;
  final String name;
  final String profileImage;
  final int followers;
  final List<SharedVerse> sharedVerses;

  CommunityUser({
    required this.userId,
    required this.name,
    required this.profileImage,
    required this.followers,
    required this.sharedVerses,
  });
}

class SharingState {
  final List<SharedVerse> sharedVerses;
  final List<CommunityUser> communityUsers;
  final List<String> userFollowing;
  final SharingStatus status;
  final String? error;
  final int totalShares;

  SharingState({
    this.sharedVerses = const [],
    this.communityUsers = const [],
    this.userFollowing = const [],
    this.status = SharingStatus.initial,
    this.error,
    this.totalShares = 0,
  });

  SharingState copyWith({
    List<SharedVerse>? sharedVerses,
    List<CommunityUser>? communityUsers,
    List<String>? userFollowing,
    SharingStatus? status,
    String? error,
    int? totalShares,
  }) {
    return SharingState(
      sharedVerses: sharedVerses ?? this.sharedVerses,
      communityUsers: communityUsers ?? this.communityUsers,
      userFollowing: userFollowing ?? this.userFollowing,
      status: status ?? this.status,
      error: error ?? this.error,
      totalShares: totalShares ?? this.totalShares,
    );
  }
}
