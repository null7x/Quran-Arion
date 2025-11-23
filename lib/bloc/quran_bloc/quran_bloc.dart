import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quran_event.dart';
part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  QuranBloc() : super(const QuranState()) {
    on<GetQuranBooksEvent>(_onGetQuranBooks);
    on<SelectQuranBookEvent>(_onSelectQuranBook);
  }

  Future<void> _onGetQuranBooks(
      GetQuranBooksEvent event, Emitter<QuranState> emit) async {
    emit(state.copyWith(quranStatus: Status.loading));
    
    try {
      // Islamic Quranic Books/Surahs
      final quranBooks = [
        'Al-Fatihah (The Opening)',
        'Al-Baqarah (The Cow)',
        'Al-Imran (The Family of Imran)',
        'An-Nisa (The Women)',
        'Al-Maidah (The Table Spread)',
        'Al-Anam (The Cattle)',
        'Al-Araf (The Heights)',
        'Al-Anfal (The Spoils of War)',
        'At-Tawbah (The Repentance)',
        'Yunus (Jonah)',
        'Hud (Hud)',
        'Yusuf (Joseph)',
        'Ar-Rad (The Thunder)',
        'Ibrahim (Abraham)',
        'Al-Hijr (The Rocky Tract)',
        'An-Nahl (The Bee)',
        'Al-Isra (The Night Journey)',
        'Al-Kahf (The Cave)',
        'Maryam (Mary)',
        'Ta-Ha (Ta-Ha)',
        'Al-Anbiya (The Prophets)',
        'Al-Hajj (The Pilgrimage)',
        'Al-Muminum (The Believers)',
        'An-Nur (The Light)',
        'Al-Furqan (The Criterion)',
        'Ash-Shuara (The Poets)',
        'An-Naml (The Ant)',
        'Al-Qasas (The Stories)',
        'Al-Ankabut (The Spider)',
        'Ar-Rum (The Roman)',
      ];

      emit(state.copyWith(
        quranBooks: quranBooks,
        quranStatus: Status.complete,
      ));
    } catch (e) {
      emit(state.copyWith(quranStatus: Status.error));
    }
  }

  Future<void> _onSelectQuranBook(
      SelectQuranBookEvent event, Emitter<QuranState> emit) async {
    emit(state.copyWith(selectedBook: event.bookName));
  }
}
