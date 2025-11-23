part of 'qari_playlist_bloc.dart';

class QariPlaylist {
  final int id;
  final String name;
  final String biography;
  final String country;
  final String imageUrl;

  QariPlaylist({
    required this.id,
    required this.name,
    required this.biography,
    required this.country,
    required this.imageUrl,
  });
}

class QariPlaylistState extends Equatable {
  final List<QariPlaylist> qariPlaylists;
  final String? selectedQariName;
  final int? selectedQariId;
  final int? playingQariId;
  final int? playingSurahNumber;
  final String? playingSurahName;
  final bool isPlaying;
  final Status status;

  const QariPlaylistState({
    this.qariPlaylists = const [],
    this.selectedQariName,
    this.selectedQariId,
    this.playingQariId,
    this.playingSurahNumber,
    this.playingSurahName,
    this.isPlaying = false,
    this.status = Status.initial,
  });

  QariPlaylistState copyWith({
    List<QariPlaylist>? qariPlaylists,
    String? selectedQariName,
    int? selectedQariId,
    int? playingQariId,
    int? playingSurahNumber,
    String? playingSurahName,
    bool? isPlaying,
    Status? status,
  }) {
    return QariPlaylistState(
      qariPlaylists: qariPlaylists ?? this.qariPlaylists,
      selectedQariName: selectedQariName ?? this.selectedQariName,
      selectedQariId: selectedQariId ?? this.selectedQariId,
      playingQariId: playingQariId ?? this.playingQariId,
      playingSurahNumber: playingSurahNumber ?? this.playingSurahNumber,
      playingSurahName: playingSurahName ?? this.playingSurahName,
      isPlaying: isPlaying ?? this.isPlaying,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    qariPlaylists,
    selectedQariName,
    selectedQariId,
    playingQariId,
    playingSurahNumber,
    playingSurahName,
    isPlaying,
    status,
  ];
}

enum Status { initial, loading, complete, error }
