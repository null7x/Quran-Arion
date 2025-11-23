import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

part 'daily_verse_event.dart';
part 'daily_verse_state.dart';

class DailyVerseBloc extends Bloc<DailyVerseEvent, DailyVerseState> {
  DailyVerseBloc() : super(const DailyVerseState()) {
    on<GetDailyVerseEvent>(_onGetDailyVerse);
    on<ShareVerseEvent>(_onShareVerse);
  }

  final List<DailyVerse> verses = [
    DailyVerse(
      surahNumber: 36,
      surahName: 'Ya-Sin',
      ayahNumber: 35,
      arabicText: 'سُبْحَانَ الَّذِي خَلَقَ الْأَزْوَاجَ كُلَّهَا',
      englishTranslation: 'Exalted is He who created all pairs - from what the earth produces and from themselves and from that which they do not know.',
      russianTranslation: 'Пречист Тот, Кто создал все пары, которые произращает земля, из самих себя и того, чего они не знают.',
      explanation: 'This verse highlights the perfection of creation where everything is created in pairs, showing the divine wisdom in Allah\'s creation.',
    ),
    DailyVerse(
      surahNumber: 55,
      surahName: 'Ar-Rahman',
      ayahNumber: 26,
      arabicText: 'كُلُّ مَن عَلَيْهَا فَانٍ',
      englishTranslation: 'Everyone upon the earth will perish.',
      russianTranslation: 'Всё на земле преходяще.',
      explanation: 'This verse reminds us of the temporary nature of this life and the importance of preparing for the hereafter.',
    ),
    DailyVerse(
      surahNumber: 94,
      surahName: 'Ash-Sharh',
      ayahNumber: 5,
      arabicText: 'فَإِنَّ مَعَ الْعُسْرِ يُسْرًا',
      englishTranslation: 'For indeed, with hardship will be ease.',
      russianTranslation: 'Воистину, с трудностью приходит облегчение.',
      explanation: 'This verse provides comfort and hope, showing that difficulties are always followed by ease, encouraging patience during hardships.',
    ),
  ];

  Future<void> _onGetDailyVerse(
      GetDailyVerseEvent event, Emitter<DailyVerseState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Get random verse based on day
      final random = Random();
      final verse = verses[random.nextInt(verses.length)];
      
      emit(state.copyWith(
        verse: verse,
        status: Status.complete,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onShareVerse(
      ShareVerseEvent event, Emitter<DailyVerseState> emit) async {
    // Share functionality would be implemented here
    try {
      print('Sharing verse: ${event.verseText}');
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
