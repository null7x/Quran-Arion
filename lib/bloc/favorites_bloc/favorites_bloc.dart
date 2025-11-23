import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesState()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
    on<GetFavoritesEvent>(_onGetFavorites);
  }

  Future<void> _onLoadFavorites(
      LoadFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    
    try {
      // В реальном приложении здесь загружаются из БД
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(status: Status.complete));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onAddFavorite(
      AddFavoriteEvent event, Emitter<FavoritesState> emit) async {
    try {
      if (!state.isFavorite(event.surahNumber)) {
        final favorite = Favorite(
          surahNumber: event.surahNumber,
          surahName: event.surahName,
          addedDate: DateTime.now(),
        );
        
        final updatedFavorites = [...state.favorites, favorite];
        emit(state.copyWith(favorites: updatedFavorites));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onRemoveFavorite(
      RemoveFavoriteEvent event, Emitter<FavoritesState> emit) async {
    try {
      final updatedFavorites = state.favorites
          .where((fav) => fav.surahNumber != event.surahNumber)
          .toList();
      
      emit(state.copyWith(favorites: updatedFavorites));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onGetFavorites(
      GetFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(status: Status.complete));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
