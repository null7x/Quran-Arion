import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:quran_arion/bloc/home_bloc/home_event.dart';
import 'package:quran_arion/bloc/home_bloc/home_state.dart';
import 'package:quran_arion/db_helper/db_helper.dart';
import 'package:quran_arion/model/audio_file_model.dart';
import 'package:quran_arion/view_model/services/audio_query_services.dart';

class HomeBloc extends Bloc<HomeEvents,HomeState>{
 final List<AudioFile> songList=[];
  final List<AudioFile> favouriteSongs=[];
  final DbHelper dbHelper;
  HomeBloc({required this.dbHelper}) : super(const HomeState()){
    on(_onSongFileEvent);
    on(_onLoadingFileStatus);
    on(_onFavSongFileEvent);
    on(_onLoadingFavStatus);
    on(_onAddToFavEvent);
    on(_onAddToAlbumEvent);
    on(_onGetAlbumsEvent);
  }
  Future<void> _onSongFileEvent(GetSongEvent event,Emitter<HomeState> emit) async {
    add(ChangeLoadingStatusSong(songStatus: Status.loading,));
    try{
      songList.clear();
      for(var item in (await AudioFileQueries.getFiles('/storage/emulated/0/Music'))){
        songList.add(item);
      }
    }catch(_){

    }
    emit(state.copyWith(songList: songList,songListStatus: Status.complete,));
  }
  Future<void> _onFavSongFileEvent(GetFavSongEvent event,Emitter<HomeState> emit) async {
    add(ChangeLoadingStatusFav(songStatus: Status.loading,));
    favouriteSongs.clear();
    for(var item in (await dbHelper.getData())){
      favouriteSongs.add(item);
    }
    emit(state.copyWith(favouriteSongs: List.from(favouriteSongs),favSongListStatus: Status.complete));
  }
  void _onLoadingFileStatus(ChangeLoadingStatusSong event,Emitter<HomeState> emit){
    emit(state.copyWith(songListStatus: event.songStatus,));
  }
  void _onLoadingFavStatus(ChangeLoadingStatusFav event,Emitter<HomeState> emit){
    emit(state.copyWith(favSongListStatus: event.songStatus,));
  }


  Future<void> _onAddToFavEvent(AddToFavouriteEvent event,Emitter<HomeState> emit) async {
    bool alreadyExist=await dbHelper.isFavoriteExists(event.file.name!);
    if(alreadyExist){
      await dbHelper.delete(event.file.name!);
      favouriteSongs.remove(event.file);
    }else{
     await dbHelper.insert(event.file);
      favouriteSongs.add(event.file);
    }
    add(GetFavSongEvent());
    // emit(state.copyWith(favouriteSongs: List.generate(favouriteSongs.length, (index) => favouriteSongs[index])));
  }
  Future<void> _onAddToAlbumEvent(AddToAlbum event,Emitter<HomeState> emit) async {
    try{
      if(Directory('/storage/emulated/0/Music').existsSync()){
      }else{
        Directory('/storage/emulated/0/Music').createSync(recursive: true);
      }

      final bool alreadyExist=File('/storage/emulated/0/Music/${event.file.name!}').existsSync();
      if(alreadyExist){
      }else{
        File(event.file.path!).copySync('/storage/emulated/0/Music/${event.file.name!}');
        songList.add(event.file);
      }
      add(GetSongEvent());
      // emit(state.copyWith(songList: List.from(songList)));

    }catch(e){
      debugPrint(e.toString());
    }

  }

  Future<void> _onGetAlbumsEvent(GetAlbumsEvent event, Emitter<HomeState> emit) async {
    try {
      // Demo albums data
      final demoAlbums = [
        Album(
          id: '1',
          name: 'Islamic Recitations',
          artist: 'Various Reciters',
          songCount: 25,
          coverUrl: '📚',
        ),
        Album(
          id: '2',
          name: 'Quran Audio',
          artist: 'As-Sudais',
          songCount: 114,
          coverUrl: '🕌',
        ),
        Album(
          id: '3',
          name: 'Duas & Adhkar',
          artist: 'Islamic Scholars',
          songCount: 50,
          coverUrl: '🤲',
        ),
        Album(
          id: '4',
          name: 'Prayer Times',
          artist: 'Daily Reminders',
          songCount: 5,
          coverUrl: '⏰',
        ),
      ];

      emit(state.copyWith(albums: demoAlbums));
      print('✅ Albums loaded: ${demoAlbums.length}');
    } catch (e) {
      print('❌ Error loading albums: $e');
      emit(state.copyWith(albums: []));
    }
  }

  List<Object> get props=>[songList,favouriteSongs];
}
