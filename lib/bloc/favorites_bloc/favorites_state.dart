part of 'favorites_bloc.dart';

class Favorite {
  final int surahNumber;
  final String surahName;
  final DateTime addedDate;

  Favorite({
    required this.surahNumber,
    required this.surahName,
    required this.addedDate,
  });

  Map<String, dynamic> toJson() => {
    'surahNumber': surahNumber,
    'surahName': surahName,
    'addedDate': addedDate.toIso8601String(),
  };

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      surahNumber: json['surahNumber'],
      surahName: json['surahName'],
      addedDate: DateTime.parse(json['addedDate']),
    );
  }
}

class FavoritesState extends Equatable {
  final List<Favorite> favorites;
  final Status status;

  const FavoritesState({
    this.favorites = const [],
    this.status = Status.initial,
  });

  FavoritesState copyWith({
    List<Favorite>? favorites,
    Status? status,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      status: status ?? this.status,
    );
  }

  bool isFavorite(int surahNumber) {
    return favorites.any((fav) => fav.surahNumber == surahNumber);
  }

  @override
  List<Object?> get props => [favorites, status];
}

enum Status { initial, loading, complete, error }
