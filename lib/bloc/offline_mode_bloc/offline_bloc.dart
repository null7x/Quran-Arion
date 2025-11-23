import 'package:flutter_bloc/flutter_bloc.dart';
import 'offline_event.dart';
import 'offline_state.dart';

class OfflineModeBloc extends Bloc<OfflineEvent, OfflineState> {
  OfflineModeBloc() : super(OfflineState()) {
    on<LoadCachedDataEvent>(_onLoadCachedData);
    on<DownloadSurahEvent>(_onDownloadSurah);
    on<DownloadQariEvent>(_onDownloadQari);
    on<DeleteCachedSurahEvent>(_onDeleteCachedSurah);
    on<ClearAllCacheEvent>(_onClearAllCache);
    on<CheckOfflineModeEvent>(_onCheckOfflineMode);
    on<GetDownloadProgressEvent>(_onGetDownloadProgress);
  }

  final List<CachedSurah> _allSurahs = List.generate(
    114,
    (index) => CachedSurah(
      surahNumber: index + 1,
      surahName: 'Surah ${index + 1}',
      isDownloaded: false,
    ),
  );

  Future<void> _onLoadCachedData(LoadCachedDataEvent event, Emitter<OfflineState> emit) async {
    emit(state.copyWith(status: OfflineStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final offlineMode = OfflineMode(cachedSurahs: _allSurahs);
      emit(state.copyWith(
        offlineMode: offlineMode,
        status: OfflineStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OfflineStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onDownloadSurah(DownloadSurahEvent event, Emitter<OfflineState> emit) async {
    try {
      emit(state.copyWith(status: OfflineStatus.loading));
      
      // Simulate download with progress
      for (int i = 0; i <= 100; i += 10) {
        await Future.delayed(const Duration(milliseconds: 200));
        final updatedSurahs = state.offlineMode.cachedSurahs.map((surah) {
          if (surah.surahNumber == event.surahNumber) {
            return surah.copyWith(
              downloadProgress: i / 100,
              isDownloaded: i == 100,
              downloadedAt: i == 100 ? DateTime.now() : null,
            );
          }
          return surah;
        }).toList();
        
        final totalSize = updatedSurahs
            .where((s) => s.isDownloaded)
            .fold<int>(0, (sum, s) => sum + s.fileSizeInMB);

        final updatedMode = state.offlineMode.copyWith(
          cachedSurahs: updatedSurahs,
          totalCacheSizeInMB: totalSize,
        );
        emit(state.copyWith(offlineMode: updatedMode));
      }
      emit(state.copyWith(status: OfflineStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: OfflineStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onDownloadQari(DownloadQariEvent event, Emitter<OfflineState> emit) async {
    try {
      emit(state.copyWith(status: OfflineStatus.loading));
      await Future.delayed(const Duration(seconds: 2));
      
      final updatedQaris = [...state.offlineMode.cachedQaris];
      if (!updatedQaris.contains(event.qariName)) {
        updatedQaris.add(event.qariName);
      }
      
      final updatedMode = state.offlineMode.copyWith(cachedQaris: updatedQaris);
      emit(state.copyWith(
        offlineMode: updatedMode,
        status: OfflineStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OfflineStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteCachedSurah(
      DeleteCachedSurahEvent event, Emitter<OfflineState> emit) async {
    try {
      final updatedSurahs = state.offlineMode.cachedSurahs.map((surah) {
        if (surah.surahNumber == event.surahNumber) {
          return surah.copyWith(
            isDownloaded: false,
            downloadProgress: 0.0,
            downloadedAt: null,
          );
        }
        return surah;
      }).toList();

      final totalSize = updatedSurahs
          .where((s) => s.isDownloaded)
          .fold<int>(0, (sum, s) => sum + s.fileSizeInMB);

      final updatedMode = state.offlineMode.copyWith(
        cachedSurahs: updatedSurahs,
        totalCacheSizeInMB: totalSize,
      );
      emit(state.copyWith(offlineMode: updatedMode));
    } catch (e) {
      emit(state.copyWith(
        status: OfflineStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onClearAllCache(ClearAllCacheEvent event, Emitter<OfflineState> emit) async {
    try {
      emit(state.copyWith(status: OfflineStatus.loading));
      await Future.delayed(const Duration(seconds: 1));
      
      final resetSurahs = _allSurahs.map((s) => s.copyWith(isDownloaded: false, downloadProgress: 0.0)).toList();
      final updatedMode = state.offlineMode.copyWith(
        cachedSurahs: resetSurahs,
        totalCacheSizeInMB: 0,
        cachedQaris: const [],
      );
      emit(state.copyWith(
        offlineMode: updatedMode,
        status: OfflineStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OfflineStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onCheckOfflineMode(
      CheckOfflineModeEvent event, Emitter<OfflineState> emit) async {
    // Simulating network check
    emit(state.copyWith(isOnline: true));
  }

  Future<void> _onGetDownloadProgress(
      GetDownloadProgressEvent event, Emitter<OfflineState> emit) async {
    try {
      final surah = state.offlineMode.cachedSurahs
          .firstWhere((s) => s.surahNumber == event.surahNumber);
      // Return state with current surah progress
      emit(state);
    } catch (e) {
      emit(state.copyWith(
        status: OfflineStatus.error,
        error: e.toString(),
      ));
    }
  }
}
