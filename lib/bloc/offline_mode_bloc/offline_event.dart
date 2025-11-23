abstract class OfflineEvent {}

class LoadCachedDataEvent extends OfflineEvent {}

class DownloadSurahEvent extends OfflineEvent {
  final int surahNumber;
  final String surahName;
  DownloadSurahEvent({required this.surahNumber, required this.surahName});
}

class DownloadQariEvent extends OfflineEvent {
  final String qariName;
  DownloadQariEvent(this.qariName);
}

class DeleteCachedSurahEvent extends OfflineEvent {
  final int surahNumber;
  DeleteCachedSurahEvent(this.surahNumber);
}

class ClearAllCacheEvent extends OfflineEvent {}

class CheckOfflineModeEvent extends OfflineEvent {}

class GetDownloadProgressEvent extends OfflineEvent {
  final int surahNumber;
  GetDownloadProgressEvent(this.surahNumber);
}
