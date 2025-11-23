part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoritesEvent extends FavoritesEvent {
  const LoadFavoritesEvent();

  @override
  List<Object> get props => [];
}

class AddFavoriteEvent extends FavoritesEvent {
  final int surahNumber;
  final String surahName;
  
  const AddFavoriteEvent(this.surahNumber, this.surahName);

  @override
  List<Object> get props => [surahNumber, surahName];
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final int surahNumber;
  
  const RemoveFavoriteEvent(this.surahNumber);

  @override
  List<Object> get props => [surahNumber];
}

class GetFavoritesEvent extends FavoritesEvent {
  const GetFavoritesEvent();

  @override
  List<Object> get props => [];
}
