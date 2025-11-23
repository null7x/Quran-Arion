enum OfflineStatus { initial, loading, success, error }

class CachedSurah {
  final int surahNumber;
  final String surahName;
  final bool isDownloaded;
  final double downloadProgress;
  final DateTime? downloadedAt;
  final int fileSizeInMB;

  CachedSurah({
    required this.surahNumber,
    required this.surahName,
    required this.isDownloaded,
    this.downloadProgress = 0.0,
    this.downloadedAt,
    this.fileSizeInMB = 5,
  });

  CachedSurah copyWith({
    int? surahNumber,
    String? surahName,
    bool? isDownloaded,
    double? downloadProgress,
    DateTime? downloadedAt,
    int? fileSizeInMB,
  }) {
    return CachedSurah(
      surahNumber: surahNumber ?? this.surahNumber,
      surahName: surahName ?? this.surahName,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      downloadedAt: downloadedAt ?? this.downloadedAt,
      fileSizeInMB: fileSizeInMB ?? this.fileSizeInMB,
    );
  }
}

class OfflineMode {
  final bool isOfflineEnabled;
  final List<CachedSurah> cachedSurahs;
  final int totalCacheSizeInMB;
  final List<String> cachedQaris;

  OfflineMode({
    this.isOfflineEnabled = false,
    this.cachedSurahs = const [],
    this.totalCacheSizeInMB = 0,
    this.cachedQaris = const [],
  });

  OfflineMode copyWith({
    bool? isOfflineEnabled,
    List<CachedSurah>? cachedSurahs,
    int? totalCacheSizeInMB,
    List<String>? cachedQaris,
  }) {
    return OfflineMode(
      isOfflineEnabled: isOfflineEnabled ?? this.isOfflineEnabled,
      cachedSurahs: cachedSurahs ?? this.cachedSurahs,
      totalCacheSizeInMB: totalCacheSizeInMB ?? this.totalCacheSizeInMB,
      cachedQaris: cachedQaris ?? this.cachedQaris,
    );
  }

  int get downloadedCount => cachedSurahs.where((s) => s.isDownloaded).length;
  
  int get totalCount => cachedSurahs.length;
}

class OfflineState {
  final OfflineMode offlineMode;
  final OfflineStatus status;
  final String? error;
  final bool isOnline;

  OfflineState({
    this.offlineMode = const OfflineMode(),
    this.status = OfflineStatus.initial,
    this.error,
    this.isOnline = true,
  });

  OfflineState copyWith({
    OfflineMode? offlineMode,
    OfflineStatus? status,
    String? error,
    bool? isOnline,
  }) {
    return OfflineState(
      offlineMode: offlineMode ?? this.offlineMode,
      status: status ?? this.status,
      error: error ?? this.error,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
