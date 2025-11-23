part of 'qari_playlist_bloc.dart';

abstract class QariPlaylistEvent extends Equatable {
  const QariPlaylistEvent();

  @override
  List<Object> get props => [];
}

class GetQariPlaylistsEvent extends QariPlaylistEvent {
  const GetQariPlaylistsEvent();

  @override
  List<Object> get props => [];
}

class SelectQariEvent extends QariPlaylistEvent {
  final String qariName;
  final int qariId;
  
  const SelectQariEvent(this.qariName, this.qariId);

  @override
  List<Object> get props => [qariName, qariId];
}

class PlayQariSurahEvent extends QariPlaylistEvent {
  final int surahNumber;
  final String surahName;
  final String qariName;
  
  const PlayQariSurahEvent(this.surahNumber, this.surahName, this.qariName);

  @override
  List<Object> get props => [surahNumber, surahName, qariName];
}

class StopQariPlaybackEvent extends QariPlaylistEvent {
  const StopQariPlaybackEvent();

  @override
  List<Object> get props => [];
}
