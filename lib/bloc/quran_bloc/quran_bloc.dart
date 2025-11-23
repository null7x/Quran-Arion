import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quran_event.dart';
part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  QuranBloc() : super(const QuranState()) {
    on<GetQuranBooksEvent>(_onGetQuranBooks);
    on<SelectQuranBookEvent>(_onSelectQuranBook);
    on<PlayQuranSurahEvent>(_onPlayQuranSurah);
    on<StopQuranPlaybackEvent>(_onStopQuranPlayback);
  }

  // Карта Сур с их аудио путями (можно заменить на реальные пути)
  final Map<int, String> surahAudioPaths = {
    1: 'assets/audio/quran/001_al_fatihah.mp3',
    2: 'assets/audio/quran/002_al_baqarah.mp3',
    3: 'assets/audio/quran/003_al_imran.mp3',
    4: 'assets/audio/quran/004_an_nisa.mp3',
    5: 'assets/audio/quran/005_al_maidah.mp3',
    6: 'assets/audio/quran/006_al_anam.mp3',
    7: 'assets/audio/quran/007_al_araf.mp3',
    8: 'assets/audio/quran/008_al_anfal.mp3',
    9: 'assets/audio/quran/009_at_tawbah.mp3',
    10: 'assets/audio/quran/010_yunus.mp3',
    11: 'assets/audio/quran/011_hud.mp3',
    12: 'assets/audio/quran/012_yusuf.mp3',
    13: 'assets/audio/quran/013_ar_rad.mp3',
    14: 'assets/audio/quran/014_ibrahim.mp3',
    15: 'assets/audio/quran/015_al_hijr.mp3',
    16: 'assets/audio/quran/016_an_nahl.mp3',
    17: 'assets/audio/quran/017_al_isra.mp3',
    18: 'assets/audio/quran/018_al_kahf.mp3',
    19: 'assets/audio/quran/019_maryam.mp3',
    20: 'assets/audio/quran/020_ta_ha.mp3',
    21: 'assets/audio/quran/021_al_anbiya.mp3',
    22: 'assets/audio/quran/022_al_hajj.mp3',
    23: 'assets/audio/quran/023_al_muminum.mp3',
    24: 'assets/audio/quran/024_an_nur.mp3',
    25: 'assets/audio/quran/025_al_furqan.mp3',
    26: 'assets/audio/quran/026_ash_shuara.mp3',
    27: 'assets/audio/quran/027_an_naml.mp3',
    28: 'assets/audio/quran/028_al_qasas.mp3',
    29: 'assets/audio/quran/029_al_ankabut.mp3',
    30: 'assets/audio/quran/030_ar_rum.mp3',
  };

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
    emit(state.copyWith(
      selectedBook: event.bookName,
      selectedSurahNumber: event.surahNumber,
    ));
  }

  Future<void> _onPlayQuranSurah(
      PlayQuranSurahEvent event, Emitter<QuranState> emit) async {
    emit(state.copyWith(
      playingSurahNumber: event.surahNumber,
      playingSurahName: event.surahName,
      isPlaying: true,
    ));
  }

  Future<void> _onStopQuranPlayback(
      StopQuranPlaybackEvent event, Emitter<QuranState> emit) async {
    emit(state.copyWith(
      isPlaying: false,
      playingSurahNumber: null,
      playingSurahName: null,
    ));
  }
}
