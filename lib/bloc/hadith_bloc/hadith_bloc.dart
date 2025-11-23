import 'package:flutter_bloc/flutter_bloc.dart';
import 'hadith_event.dart';
import 'hadith_state.dart';

class HadithBloc extends Bloc<HadithEvent, HadithState> {
  HadithBloc() : super(HadithState()) {
    on<LoadHadithsEvent>(_onLoadHadiths);
    on<SearchHadithEvent>(_onSearchHadith);
    on<AddHadithToFavoritesEvent>(_onAddFavorite);
    on<RemoveHadithFromFavoritesEvent>(_onRemoveFavorite);
    on<LoadFavoriteHadithsEvent>(_onLoadFavorites);
    on<FilterByCategoryEvent>(_onFilterByCategory);
  }

  final List<Hadith> _allHadiths = [
    Hadith(
      id: 1,
      text: 'The best of you are those who have the best manners and character.',
      narrator: 'Prophet Muhammad (PBUH)',
      category: 'Morality',
      explanation: 'This hadith emphasizes the importance of good character and moral conduct in Islam.',
      dateAdded: DateTime.now(),
    ),
    Hadith(
      id: 2,
      text: 'Seeking knowledge is a duty upon every Muslim.',
      narrator: 'Prophet Muhammad (PBUH)',
      category: 'Knowledge',
      explanation: 'Islam highly encourages the pursuit of knowledge for both men and women.',
      dateAdded: DateTime.now(),
    ),
    Hadith(
      id: 3,
      text: 'The greatest wealth is the wealth of the soul.',
      narrator: 'Prophet Muhammad (PBUH)',
      category: 'Wisdom',
      explanation: 'True wealth comes from inner peace and spiritual richness, not material possessions.',
      dateAdded: DateTime.now(),
    ),
    Hadith(
      id: 4,
      text: 'Modesty is a branch of faith.',
      narrator: 'Prophet Muhammad (PBUH)',
      category: 'Character',
      explanation: 'Modesty and humility are essential qualities of a faithful Muslim.',
      dateAdded: DateTime.now(),
    ),
    Hadith(
      id: 5,
      text: 'The best house is the house where an orphan is treated kindly.',
      narrator: 'Prophet Muhammad (PBUH)',
      category: 'Compassion',
      explanation: 'Islam encourages kindness and care for orphans and vulnerable members of society.',
      dateAdded: DateTime.now(),
    ),
  ];

  Future<void> _onLoadHadiths(LoadHadithsEvent event, Emitter<HadithState> emit) async {
    emit(state.copyWith(status: HadithStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(
        hadiths: _allHadiths,
        status: HadithStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HadithStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onSearchHadith(SearchHadithEvent event, Emitter<HadithState> emit) async {
    emit(state.copyWith(status: HadithStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final results = _allHadiths
          .where((hadith) =>
              hadith.text.toLowerCase().contains(event.query.toLowerCase()) ||
              hadith.narrator.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(state.copyWith(
        hadiths: results,
        status: HadithStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HadithStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onAddFavorite(AddHadithToFavoritesEvent event, Emitter<HadithState> emit) async {
    try {
      final hadith = _allHadiths.firstWhere((h) => h.id == event.hadithId);
      final updatedFavorites = [...state.favorites];
      if (!updatedFavorites.any((h) => h.id == event.hadithId)) {
        updatedFavorites.add(hadith);
      }
      emit(state.copyWith(favorites: updatedFavorites));
    } catch (e) {
      emit(state.copyWith(
        status: HadithStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveFavorite(RemoveHadithFromFavoritesEvent event, Emitter<HadithState> emit) async {
    try {
      final updatedFavorites = state.favorites.where((h) => h.id != event.hadithId).toList();
      emit(state.copyWith(favorites: updatedFavorites));
    } catch (e) {
      emit(state.copyWith(
        status: HadithStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadFavorites(LoadFavoriteHadithsEvent event, Emitter<HadithState> emit) async {
    emit(state.copyWith(status: HadithStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      emit(state.copyWith(
        hadiths: state.favorites,
        status: HadithStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HadithStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onFilterByCategory(FilterByCategoryEvent event, Emitter<HadithState> emit) async {
    emit(state.copyWith(status: HadithStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final filtered = _allHadiths.where((h) => h.category == event.category).toList();
      emit(state.copyWith(
        hadiths: filtered,
        selectedCategory: event.category,
        status: HadithStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HadithStatus.error,
        error: e.toString(),
      ));
    }
  }
}
