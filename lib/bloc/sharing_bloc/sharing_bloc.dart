import 'package:flutter_bloc/flutter_bloc.dart';
import 'sharing_event.dart';
import 'sharing_state.dart';

class SharingBloc extends Bloc<SharingEvent, SharingState> {
  SharingBloc() : super(SharingState()) {
    on<LoadSharingEvent>(_onLoadSharing);
    on<ShareVerseEvent>(_onShareVerse);
    on<ShareHadithEvent>(_onShareHadith);
    on<AddCommentToVerseEvent>(_onAddComment);
    on<LikeVerseEvent>(_onLikeVerse);
    on<GetCommunitySharingEvent>(_onGetCommunitySharing);
    on<FollowUserEvent>(_onFollowUser);
  }

  final List<CommunityUser> _communityUsers = [
    CommunityUser(
      userId: 'user1',
      name: 'Ahmed Al-Rashid',
      profileImage: 'assets/images/user1.png',
      followers: 524,
      sharedVerses: [],
    ),
    CommunityUser(
      userId: 'user2',
      name: 'Fatima Khan',
      profileImage: 'assets/images/user2.png',
      followers: 789,
      sharedVerses: [],
    ),
    CommunityUser(
      userId: 'user3',
      name: 'Hassan Mohammed',
      profileImage: 'assets/images/user3.png',
      followers: 312,
      sharedVerses: [],
    ),
  ];

  Future<void> _onLoadSharing(LoadSharingEvent event, Emitter<SharingState> emit) async {
    emit(state.copyWith(status: SharingStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(
        communityUsers: _communityUsers,
        status: SharingStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SharingStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onShareVerse(ShareVerseEvent event, Emitter<SharingState> emit) async {
    try {
      final sharedVerse = SharedVerse(
        surahNumber: event.surahNumber,
        ayahNumber: event.ayahNumber,
        arabicText: event.arabicText,
        translation: event.translation,
        likes: 0,
        comments: const [],
        sharedAt: DateTime.now(),
        sharedBy: 'CurrentUser',
      );
      final updatedVerses = [...state.sharedVerses, sharedVerse];
      emit(state.copyWith(
        sharedVerses: updatedVerses,
        totalShares: state.totalShares + 1,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SharingStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onShareHadith(ShareHadithEvent event, Emitter<SharingState> emit) async {
    try {
      // Similar to sharing verse but for hadith
      emit(state.copyWith(totalShares: state.totalShares + 1));
    } catch (e) {
      emit(state.copyWith(
        status: SharingStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onAddComment(
      AddCommentToVerseEvent event, Emitter<SharingState> emit) async {
    try {
      final updatedVerses = state.sharedVerses.map((verse) {
        if (verse.surahNumber == event.surahNumber &&
            verse.ayahNumber == event.ayahNumber) {
          final updatedComments = [...verse.comments, event.comment];
          return verse.copyWith(comments: updatedComments);
        }
        return verse;
      }).toList();
      emit(state.copyWith(sharedVerses: updatedVerses));
    } catch (e) {
      emit(state.copyWith(
        status: SharingStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLikeVerse(LikeVerseEvent event, Emitter<SharingState> emit) async {
    try {
      final updatedVerses = state.sharedVerses.map((verse) {
        if (verse.surahNumber == event.surahNumber &&
            verse.ayahNumber == event.ayahNumber) {
          return verse.copyWith(likes: verse.likes + 1);
        }
        return verse;
      }).toList();
      emit(state.copyWith(sharedVerses: updatedVerses));
    } catch (e) {
      emit(state.copyWith(
        status: SharingStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onGetCommunitySharing(
      GetCommunitySharingEvent event, Emitter<SharingState> emit) async {
    emit(state.copyWith(status: SharingStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(
        communityUsers: _communityUsers,
        status: SharingStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SharingStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onFollowUser(FollowUserEvent event, Emitter<SharingState> emit) async {
    try {
      final updatedFollowing = [...state.userFollowing, event.userId];
      emit(state.copyWith(userFollowing: updatedFollowing));
    } catch (e) {
      emit(state.copyWith(
        status: SharingStatus.error,
        error: e.toString(),
      ));
    }
  }
}
