abstract class SharingEvent {}

class LoadSharingEvent extends SharingEvent {}

class ShareVerseEvent extends SharingEvent {
  final int surahNumber;
  final int ayahNumber;
  final String arabicText;
  final String translation;
  ShareVerseEvent({
    required this.surahNumber,
    required this.ayahNumber,
    required this.arabicText,
    required this.translation,
  });
}

class ShareHadithEvent extends SharingEvent {
  final String hadithText;
  final String narrator;
  ShareHadithEvent({required this.hadithText, required this.narrator});
}

class AddCommentToVerseEvent extends SharingEvent {
  final int surahNumber;
  final int ayahNumber;
  final String comment;
  AddCommentToVerseEvent({
    required this.surahNumber,
    required this.ayahNumber,
    required this.comment,
  });
}

class LikeVerseEvent extends SharingEvent {
  final int surahNumber;
  final int ayahNumber;
  LikeVerseEvent({required this.surahNumber, required this.ayahNumber});
}

class GetCommunitySharingEvent extends SharingEvent {}

class FollowUserEvent extends SharingEvent {
  final String userId;
  FollowUserEvent(this.userId);
}
