import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:convert';

part 'quran_event.dart';
part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  late AudioPlayer _audioPlayer;
  
  QuranBloc() : super(const QuranState()) {
    _initializeAudioPlayer();
    on<GetQuranBooksEvent>(_onGetQuranBooks);
    on<SelectQuranBookEvent>(_onSelectQuranBook);
    on<PlayQuranSurahEvent>(_onPlayQuranSurah);
    on<StopQuranPlaybackEvent>(_onStopQuranPlayback);
  }
  
  void _initializeAudioPlayer() {
    try {
      _audioPlayer = AudioPlayer();
      print('✅ AudioPlayer initialized successfully');
    } catch (e) {
      print('❌ Error initializing AudioPlayer: $e');
    }
  }

  // Al-Quran Cloud CDN URLs - используем онлайн API вместо локальных файлов
  // As-Sudais reciter, 128 kbps quality
  String _getSurahUrl(int surahNumber) {
    String paddedNumber = surahNumber.toString().padLeft(3, '0');
    return 'https://cdn.islamic.network/quran/audio/128/as-sudais/$paddedNumber.mp3';
  }

  // Карта Сур с их аудио URL (все 114 Сур Корана)
  final Map<int, String> surahAudioPaths = {
    1: 'https://cdn.islamic.network/quran/audio/128/as-sudais/001.mp3',
    2: 'https://cdn.islamic.network/quran/audio/128/as-sudais/002.mp3',
    3: 'https://cdn.islamic.network/quran/audio/128/as-sudais/003.mp3',
    4: 'https://cdn.islamic.network/quran/audio/128/as-sudais/004.mp3',
    5: 'https://cdn.islamic.network/quran/audio/128/as-sudais/005.mp3',
    6: 'https://cdn.islamic.network/quran/audio/128/as-sudais/006.mp3',
    7: 'https://cdn.islamic.network/quran/audio/128/as-sudais/007.mp3',
    8: 'https://cdn.islamic.network/quran/audio/128/as-sudais/008.mp3',
    9: 'https://cdn.islamic.network/quran/audio/128/as-sudais/009.mp3',
    10: 'https://cdn.islamic.network/quran/audio/128/as-sudais/010.mp3',
    11: 'https://cdn.islamic.network/quran/audio/128/as-sudais/011.mp3',
    12: 'https://cdn.islamic.network/quran/audio/128/as-sudais/012.mp3',
    13: 'https://cdn.islamic.network/quran/audio/128/as-sudais/013.mp3',
    14: 'https://cdn.islamic.network/quran/audio/128/as-sudais/014.mp3',
    15: 'https://cdn.islamic.network/quran/audio/128/as-sudais/015.mp3',
    16: 'https://cdn.islamic.network/quran/audio/128/as-sudais/016.mp3',
    17: 'https://cdn.islamic.network/quran/audio/128/as-sudais/017.mp3',
    18: 'https://cdn.islamic.network/quran/audio/128/as-sudais/018.mp3',
    19: 'https://cdn.islamic.network/quran/audio/128/as-sudais/019.mp3',
    20: 'https://cdn.islamic.network/quran/audio/128/as-sudais/020.mp3',
    21: 'https://cdn.islamic.network/quran/audio/128/as-sudais/021.mp3',
    22: 'https://cdn.islamic.network/quran/audio/128/as-sudais/022.mp3',
    23: 'https://cdn.islamic.network/quran/audio/128/as-sudais/023.mp3',
    24: 'https://cdn.islamic.network/quran/audio/128/as-sudais/024.mp3',
    25: 'https://cdn.islamic.network/quran/audio/128/as-sudais/025.mp3',
    26: 'https://cdn.islamic.network/quran/audio/128/as-sudais/026.mp3',
    27: 'https://cdn.islamic.network/quran/audio/128/as-sudais/027.mp3',
    28: 'https://cdn.islamic.network/quran/audio/128/as-sudais/028.mp3',
    29: 'https://cdn.islamic.network/quran/audio/128/as-sudais/029.mp3',
    30: 'https://cdn.islamic.network/quran/audio/128/as-sudais/030.mp3',
    31: 'https://cdn.islamic.network/quran/audio/128/as-sudais/031.mp3',
    32: 'https://cdn.islamic.network/quran/audio/128/as-sudais/032.mp3',
    33: 'https://cdn.islamic.network/quran/audio/128/as-sudais/033.mp3',
    34: 'https://cdn.islamic.network/quran/audio/128/as-sudais/034.mp3',
    35: 'https://cdn.islamic.network/quran/audio/128/as-sudais/035.mp3',
    36: 'https://cdn.islamic.network/quran/audio/128/as-sudais/036.mp3',
    37: 'https://cdn.islamic.network/quran/audio/128/as-sudais/037.mp3',
    38: 'https://cdn.islamic.network/quran/audio/128/as-sudais/038.mp3',
    39: 'https://cdn.islamic.network/quran/audio/128/as-sudais/039.mp3',
    40: 'https://cdn.islamic.network/quran/audio/128/as-sudais/040.mp3',
    41: 'https://cdn.islamic.network/quran/audio/128/as-sudais/041.mp3',
    42: 'https://cdn.islamic.network/quran/audio/128/as-sudais/042.mp3',
    43: 'https://cdn.islamic.network/quran/audio/128/as-sudais/043.mp3',
    44: 'https://cdn.islamic.network/quran/audio/128/as-sudais/044.mp3',
    45: 'https://cdn.islamic.network/quran/audio/128/as-sudais/045.mp3',
    46: 'https://cdn.islamic.network/quran/audio/128/as-sudais/046.mp3',
    47: 'https://cdn.islamic.network/quran/audio/128/as-sudais/047.mp3',
    48: 'https://cdn.islamic.network/quran/audio/128/as-sudais/048.mp3',
    49: 'https://cdn.islamic.network/quran/audio/128/as-sudais/049.mp3',
    50: 'https://cdn.islamic.network/quran/audio/128/as-sudais/050.mp3',
    51: 'https://cdn.islamic.network/quran/audio/128/as-sudais/051.mp3',
    52: 'https://cdn.islamic.network/quran/audio/128/as-sudais/052.mp3',
    53: 'https://cdn.islamic.network/quran/audio/128/as-sudais/053.mp3',
    54: 'https://cdn.islamic.network/quran/audio/128/as-sudais/054.mp3',
    55: 'https://cdn.islamic.network/quran/audio/128/as-sudais/055.mp3',
    56: 'https://cdn.islamic.network/quran/audio/128/as-sudais/056.mp3',
    57: 'https://cdn.islamic.network/quran/audio/128/as-sudais/057.mp3',
    58: 'https://cdn.islamic.network/quran/audio/128/as-sudais/058.mp3',
    59: 'https://cdn.islamic.network/quran/audio/128/as-sudais/059.mp3',
    60: 'https://cdn.islamic.network/quran/audio/128/as-sudais/060.mp3',
    61: 'https://cdn.islamic.network/quran/audio/128/as-sudais/061.mp3',
    62: 'https://cdn.islamic.network/quran/audio/128/as-sudais/062.mp3',
    63: 'https://cdn.islamic.network/quran/audio/128/as-sudais/063.mp3',
    64: 'https://cdn.islamic.network/quran/audio/128/as-sudais/064.mp3',
    65: 'https://cdn.islamic.network/quran/audio/128/as-sudais/065.mp3',
    66: 'https://cdn.islamic.network/quran/audio/128/as-sudais/066.mp3',
    67: 'https://cdn.islamic.network/quran/audio/128/as-sudais/067.mp3',
    68: 'https://cdn.islamic.network/quran/audio/128/as-sudais/068.mp3',
    69: 'https://cdn.islamic.network/quran/audio/128/as-sudais/069.mp3',
    70: 'https://cdn.islamic.network/quran/audio/128/as-sudais/070.mp3',
    71: 'https://cdn.islamic.network/quran/audio/128/as-sudais/071.mp3',
    72: 'https://cdn.islamic.network/quran/audio/128/as-sudais/072.mp3',
    73: 'https://cdn.islamic.network/quran/audio/128/as-sudais/073.mp3',
    74: 'https://cdn.islamic.network/quran/audio/128/as-sudais/074.mp3',
    75: 'https://cdn.islamic.network/quran/audio/128/as-sudais/075.mp3',
    76: 'https://cdn.islamic.network/quran/audio/128/as-sudais/076.mp3',
    77: 'https://cdn.islamic.network/quran/audio/128/as-sudais/077.mp3',
    78: 'https://cdn.islamic.network/quran/audio/128/as-sudais/078.mp3',
    79: 'https://cdn.islamic.network/quran/audio/128/as-sudais/079.mp3',
    80: 'https://cdn.islamic.network/quran/audio/128/as-sudais/080.mp3',
    81: 'https://cdn.islamic.network/quran/audio/128/as-sudais/081.mp3',
    82: 'https://cdn.islamic.network/quran/audio/128/as-sudais/082.mp3',
    83: 'https://cdn.islamic.network/quran/audio/128/as-sudais/083.mp3',
    84: 'https://cdn.islamic.network/quran/audio/128/as-sudais/084.mp3',
    85: 'https://cdn.islamic.network/quran/audio/128/as-sudais/085.mp3',
    86: 'https://cdn.islamic.network/quran/audio/128/as-sudais/086.mp3',
    87: 'https://cdn.islamic.network/quran/audio/128/as-sudais/087.mp3',
    88: 'https://cdn.islamic.network/quran/audio/128/as-sudais/088.mp3',
    89: 'https://cdn.islamic.network/quran/audio/128/as-sudais/089.mp3',
    90: 'https://cdn.islamic.network/quran/audio/128/as-sudais/090.mp3',
    91: 'https://cdn.islamic.network/quran/audio/128/as-sudais/091.mp3',
    92: 'https://cdn.islamic.network/quran/audio/128/as-sudais/092.mp3',
    93: 'https://cdn.islamic.network/quran/audio/128/as-sudais/093.mp3',
    94: 'https://cdn.islamic.network/quran/audio/128/as-sudais/094.mp3',
    95: 'https://cdn.islamic.network/quran/audio/128/as-sudais/095.mp3',
    96: 'https://cdn.islamic.network/quran/audio/128/as-sudais/096.mp3',
    97: 'https://cdn.islamic.network/quran/audio/128/as-sudais/097.mp3',
    98: 'https://cdn.islamic.network/quran/audio/128/as-sudais/098.mp3',
    99: 'https://cdn.islamic.network/quran/audio/128/as-sudais/099.mp3',
    100: 'https://cdn.islamic.network/quran/audio/128/as-sudais/100.mp3',
    101: 'https://cdn.islamic.network/quran/audio/128/as-sudais/101.mp3',
    102: 'https://cdn.islamic.network/quran/audio/128/as-sudais/102.mp3',
    103: 'https://cdn.islamic.network/quran/audio/128/as-sudais/103.mp3',
    104: 'https://cdn.islamic.network/quran/audio/128/as-sudais/104.mp3',
    105: 'https://cdn.islamic.network/quran/audio/128/as-sudais/105.mp3',
    106: 'https://cdn.islamic.network/quran/audio/128/as-sudais/106.mp3',
    107: 'https://cdn.islamic.network/quran/audio/128/as-sudais/107.mp3',
    108: 'https://cdn.islamic.network/quran/audio/128/as-sudais/108.mp3',
    109: 'https://cdn.islamic.network/quran/audio/128/as-sudais/109.mp3',
    110: 'https://cdn.islamic.network/quran/audio/128/as-sudais/110.mp3',
    111: 'https://cdn.islamic.network/quran/audio/128/as-sudais/111.mp3',
    112: 'https://cdn.islamic.network/quran/audio/128/as-sudais/112.mp3',
    113: 'https://cdn.islamic.network/quran/audio/128/as-sudais/113.mp3',
    114: 'https://cdn.islamic.network/quran/audio/128/as-sudais/114.mp3',
  };

  Future<void> _onGetQuranBooks(
      GetQuranBooksEvent event, Emitter<QuranState> emit) async {
    emit(state.copyWith(quranStatus: Status.loading));
    
    try {
      // All 114 Surahs of the Holy Quran
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
        'Ash-Shuera (The Poets)',
        'An-Naml (The Ant)',
        'Al-Qasas (The Stories)',
        'Al-Ankabut (The Spider)',
        'Ar-Rum (The Roman)',
        'Luqman (Luqman)',
        'As-Sajdah (The Prostration)',
        'Al-Ahzab (The Confederates)',
        'Saba (Sheba)',
        'Fatir (Originator)',
        'Ya-Sin (Ya-Sin)',
        'As-Saffat (Those Who Set the Ranks)',
        'Sad (Sad)',
        'Az-Zumar (The Groups)',
        'Ghafir (The Forgiver)',
        'Fussilat (Explained in Detail)',
        'Ash-Shura (Consultation)',
        'Az-Zukhruf (The Ornament)',
        'Ad-Dukhan (The Smoke)',
        'Al-Jathiya (The Crouching)',
        'Al-Ahqaf (The Winds)',
        'Muhammad (Muhammad)',
        'Al-Fath (The Victory)',
        'Al-Hujurat (The Rooms)',
        'Qaf (Qaf)',
        'Adh-Dhariyat (The Scatterers)',
        'At-Tur (The Mount)',
        'An-Najm (The Star)',
        'Al-Qamar (The Moon)',
        'Ar-Rahman (The Most Merciful)',
        'Al-Waqiah (The Inevitable)',
        'Al-Hadid (The Iron)',
        'Al-Mujadalah (The Pleading Woman)',
        'Al-Hashr (The Exile)',
        'Al-Mumtahanah (She That Is to Be Examined)',
        'As-Saff (The Ranks)',
        'Al-Jumuah (The Friday)',
        'Al-Munafiqun (The Hypocrites)',
        'At-Taghabun (The Mutual Loss)',
        'At-Talaq (The Divorce)',
        'At-Tahrim (The Prohibition)',
        'Al-Mulk (The Kingdom)',
        'Al-Qalam (The Pen)',
        'Al-Haqqah (The Inevitable Reality)',
        'Al-Maarij (The Ascending Stairways)',
        'Nuh (Noah)',
        'Al-Jinn (The Jinn)',
        'Al-Muzzammil (The Enveloped One)',
        'Al-Muddaththir (The Cloaked One)',
        'Al-Qiyamah (The Resurrection)',
        'Al-Insan (The Human)',
        'Al-Mursalat (Those Sent Forth)',
        'An-Naba (The Announcement)',
        'An-Naziat (Those Who Tear Out)',
        'Abasa (He Frowned)',
        'At-Takwir (The Overthrowing)',
        'Al-Infitar (The Splitting)',
        'Al-Mutaffifin (Those Who Deal in Fraud)',
        'Al-Inshiqaq (The Splitting Asunder)',
        'Al-Buruj (The Constellations)',
        'At-Tariq (The Nightcomer)',
        'Al-Ala (The Most High)',
        'Al-Ghashiyah (The Overwhelming)',
        'Al-Fajr (The Dawn)',
        'Al-Balad (The City)',
        'Ash-Shams (The Sun)',
        'Al-Lail (The Night)',
        'Ad-Duha (The Forenoon)',
        'Ash-Sharh (The Opening)',
        'At-Tin (The Fig)',
        'Al-Alaq (The Clot)',
        'Al-Qadr (The Power)',
        'Al-Bayyinah (The Clear Proof)',
        'Az-Zalzalah (The Earthquake)',
        'Al-Adiyat (The Charging Steeds)',
        'Al-Qaria (The Striking Hour)',
        'At-Takathur (The Rivalry)',
        'Al-Asr (The Declining Day)',
        'Al-Humaza (The Slanderer)',
        'Al-Fil (The Elephant)',
        'Quraysh (Quraysh)',
        'Al-Maun (The Small Kindness)',
        'Al-Kawthar (The Abundance)',
        'Al-Kafirun (The Disbelievers)',
        'An-Nasr (The Victory)',
        'Al-Lahab (The Flame)',
        'Al-Ikhlas (The Oneness)',
        'Al-Falaq (The Dawn)',
        'An-Nas (Mankind)',
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
    try {
      print('🎵 Playing Surah #${event.surahNumber}: ${event.surahName}');
      
      // Update state immediately
      emit(state.copyWith(
        playingSurahNumber: event.surahNumber,
        playingSurahName: event.surahName,
        isPlaying: true,
      ));

      // Stop previous playback
      try {
        if (_audioPlayer.playing) {
          await _audioPlayer.stop();
          print('⏹️ Stopped previous playback');
        }
      } catch (e) {
        print('⚠️ Error stopping previous playback: $e');
      }

      // Construct audio URL
      final surahNumber = event.surahNumber.toString().padLeft(3, '0');
      final audioUrl = 'https://cdn.islamic.network/quran/audio/128/as-sudais/$surahNumber.mp3';
      
      print('🔗 URL: $audioUrl');
      print('⏳ Loading audio...');
      
      // Try to set and play audio using AudioSource.uri for better compatibility
      try {
        // Use AudioSource.uri which handles URL streams better than setUrl
        await _audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(audioUrl)),
          preload: false,
        );
        print('✅ Audio loaded');
        
        // Start playback
        await _audioPlayer.play();
        print('▶️ Playback started');
        
        // Monitor playback state
        _audioPlayer.playerStateStream.listen((playerState) {
          print('📊 Playback state: ${playerState.processingState}');
          if (playerState.processingState == ProcessingState.completed) {
            print('✅ Playback completed');
            emit(this.state.copyWith(isPlaying: false));
          }
        });
        
      } catch (playError) {
        print('❌ Playback error: $playError');
        emit(state.copyWith(isPlaying: false));
      }
      
    } catch (e, stackTrace) {
      print('❌ Error in _onPlayQuranSurah: $e');
      print('Stack trace: $stackTrace');
      emit(state.copyWith(isPlaying: false));
    }
  }

  Future<void> _onStopQuranPlayback(
      StopQuranPlaybackEvent event, Emitter<QuranState> emit) async {
    try {
      await _audioPlayer.stop();
      emit(state.copyWith(
        isPlaying: false,
        playingSurahNumber: null,
        playingSurahName: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isPlaying: false,
        playingSurahNumber: null,
        playingSurahName: null,
      ));
    }
  }
}
