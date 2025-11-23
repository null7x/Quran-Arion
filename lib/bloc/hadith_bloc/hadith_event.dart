abstract class HadithEvent {}

class LoadHadithsEvent extends HadithEvent {
  final String? category;
  LoadHadithsEvent({this.category});
}

class SearchHadithEvent extends HadithEvent {
  final String query;
  SearchHadithEvent(this.query);
}

class AddHadithToFavoritesEvent extends HadithEvent {
  final int hadithId;
  AddHadithToFavoritesEvent(this.hadithId);
}

class RemoveHadithFromFavoritesEvent extends HadithEvent {
  final int hadithId;
  RemoveHadithFromFavoritesEvent(this.hadithId);
}

class LoadFavoriteHadithsEvent extends HadithEvent {}

class FilterByCategoryEvent extends HadithEvent {
  final String category;
  FilterByCategoryEvent(this.category);
}
