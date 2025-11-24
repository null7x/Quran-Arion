import 'package:equatable/equatable.dart';
import 'package:quran_arion/model/audio_file_model.dart';

enum Status{loading,complete}

// Album model
class Album {
  final String id;
  final String name;
  final String? coverUrl;
  final String? artist;
  final int songCount;

  Album({
    required this.id,
    required this.name,
    this.coverUrl,
    this.artist,
    required this.songCount,
  });
}

class HomeState extends Equatable {
  final List<AudioFile> songList;
  final Status songListStatus;
  final Status favSongListStatus;
  final List<AudioFile> favouriteSongs;
  final List<Album> albums;
  
  const HomeState({
    this.songList = const [], 
    this.favouriteSongs = const [],
    this.albums = const [],
    this.favSongListStatus = Status.loading,
    this.songListStatus = Status.loading
  });
  
  HomeState copyWith({
    List<AudioFile>? songList, 
    List<AudioFile>? favouriteSongs,
    List<Album>? albums,
    Status? favSongListStatus,
    Status? songListStatus
  }) {
    return HomeState(
      favouriteSongs: favouriteSongs ?? this.favouriteSongs,
      songList: songList ?? this.songList,
      albums: albums ?? this.albums,
      favSongListStatus: favSongListStatus ?? this.favSongListStatus,
      songListStatus: songListStatus ?? this.songListStatus
    );
  }
  
  @override
  List<Object> get props => [songList,favouriteSongs,albums,songListStatus,favSongListStatus];
}
