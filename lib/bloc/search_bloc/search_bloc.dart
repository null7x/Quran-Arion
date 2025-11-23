import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/quran_bloc/quran_bloc.dart';
import 'package:quran_arion/bloc/qari_playlist_bloc/qari_playlist_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<String> surahs = [
    'Al-Fatiha', 'Al-Baqarah', 'Al-Imran', 'An-Nisa', 'Al-Ma\'idah',
    'Al-An\'am', 'Al-A\'raf', 'Al-Anfal', 'At-Taubah', 'Yunus',
    'Hud', 'Yusuf', 'Ar-Ra\'d', 'Ibrahim', 'Al-Hijr',
    'An-Nahl', 'Al-Isra', 'Al-Kahf', 'Maryam', 'Taha',
    'Al-Anbiya', 'Al-Hajj', 'Al-Mu\'minun', 'An-Nur', 'Al-Furqan',
    'Ash-Shu\'ara', 'An-Naml', 'Al-Qasas', 'Al-Ankabut', 'Ar-Rum',
    'Luqman', 'As-Sajdah', 'Al-Ahzab', 'Saba', 'Fatir',
    'Ya-Sin', 'As-Saffat', 'Sad', 'Az-Zumar', 'Ghafir',
    'Fussilat', 'Ash-Shura', 'Az-Zukhruf', 'Ad-Dukhan', 'Al-Jathiyah',
    'Al-Ahqaf', 'Muhammad', 'Al-Fath', 'Al-Hujurat', 'Qaf',
    'Adh-Dhariyat', 'At-Tur', 'An-Najm', 'Al-Qamar', 'Ar-Rahman',
    'Al-Waqi\'ah', 'Al-Hadid', 'Al-Mujadilah', 'Al-Hashr', 'Al-Mumtahanah',
    'As-Saff', 'Al-Jumu\'ah', 'Al-Munafiqun', 'At-Taghabun', 'At-Talaq',
    'At-Tahrim', 'Al-Mulk', 'Al-Qalam', 'Al-Haqqah', 'Al-Ma\'arij',
    'Nuh', 'Al-Jinn', 'Al-Muzzammil', 'Al-Muddaththir', 'Al-Qiyamah',
    'Ad-Dahr', 'Al-Mursalat', 'An-Naba', 'An-Nazi\'at', 'Abasa',
    'At-Takwir', 'Al-Infitar', 'Al-Mutaffifin', 'Al-Inshiqaq', 'Al-Buruj',
    'At-Tariq', 'Al-A\'la', 'Al-Ghashiyah', 'Al-Fajr', 'Al-Balad',
    'Ash-Shams', 'Al-Lail', 'Ad-Duha', 'Ash-Sharh', 'At-Tin',
    'Al-Alaq', 'Al-Qadr', 'Al-Bayyinah', 'Az-Zalzalah', 'Al-Adiyat',
    'Al-Qariah', 'At-Takathur', 'Al-Asr', 'Al-Humazah', 'Al-Fil',
    'Quraysh', 'Al-Ma\'un', 'Al-Kawthar', 'Al-Kafirun', 'An-Nasr',
    'Al-Lahab', 'Al-Ikhlas', 'Al-Falaq', 'An-Nas'
  ];

  final List<String> qaris = [
    'Abdul Basit', 'As-Sudais', 'Al-Tablawi', 'Alafasy',
    'Al-Ghamdi', 'Al-Muaiqly', 'Al-Sisi', 'Al-Ajmi'
  ];

  SearchBloc() : super(const SearchState()) {
    on<SearchQueryEvent>(_onSearchQuery);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onSearchQuery(
      SearchQueryEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(query: event.query, isLoading: true));

    await Future.delayed(const Duration(milliseconds: 300));

    final query = event.query.toLowerCase().trim();
    final results = <SearchResult>[];

    if (query.isEmpty) {
      emit(state.copyWith(results: [], isLoading: false));
      return;
    }

    // Search in Surahs
    for (int i = 0; i < surahs.length; i++) {
      if (surahs[i].toLowerCase().contains(query) ||
          (i + 1).toString().contains(query)) {
        results.add(SearchResult(
          type: 'surah',
          id: i + 1,
          name: surahs[i],
          subtitle: 'Chapter ${i + 1}',
        ));
      }
    }

    // Search in Qaris
    for (int i = 0; i < qaris.length; i++) {
      if (qaris[i].toLowerCase().contains(query)) {
        results.add(SearchResult(
          type: 'qari',
          id: i,
          name: qaris[i],
          subtitle: 'Reciter',
        ));
      }
    }

    emit(state.copyWith(results: results, isLoading: false));
  }

  Future<void> _onClearSearch(
      ClearSearchEvent event, Emitter<SearchState> emit) async {
    emit(const SearchState());
  }
}
