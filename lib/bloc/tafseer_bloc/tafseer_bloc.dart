import 'package:flutter_bloc/flutter_bloc.dart';
import 'tafseer_event.dart';
import 'tafseer_state.dart';

class TafseerBloc extends Bloc<TafseerEvent, TafseerState> {
  TafseerBloc() : super(TafseerState()) {
    on<LoadTafseerEvent>(_onLoadTafseer);
    on<LoadAllTafseersEvent>(_onLoadAllTafseers);
    on<SearchTafseerEvent>(_onSearchTafseer);
    on<ChangeTafseerStyleEvent>(_onChangeTafseerStyle);
    on<SaveTafseerNoteEvent>(_onSaveTafseerNote);
  }

  final List<TafseerExplanation> _allTafseers = [
    TafseerExplanation(
      surahNumber: 1,
      ayahNumber: 1,
      arabicText: 'الحمد لله رب العالمين',
      englishTranslation: 'All praise is due to Allah, Lord of the worlds',
      classicalTafseer: 'This verse establishes that all praise belongs to Allah alone.',
      modernInterpretation: 'A declaration of monotheism and gratitude to Allah.',
      historicalContext: 'Revealed in Mecca as the opening of Surah Al-Fatiha.',
      moralLesson: 'Recognize Allah\'s lordship and give thanks for His blessings.',
      dateAdded: DateTime.now(),
    ),
    TafseerExplanation(
      surahNumber: 2,
      ayahNumber: 255,
      arabicText: 'الله لا إله إلا هو الحي القيوم',
      englishTranslation: 'Allah - there is no deity except Him, the Ever-Living, the Sustainer',
      classicalTafseer: 'This is the greatest verse in the Quran (Ayat al-Kursi).',
      modernInterpretation: 'A comprehensive declaration of Allah\'s attributes and power.',
      historicalContext: 'Part of Surah Al-Baqarah, revealed in Medina.',
      moralLesson: 'Understanding the magnificence and omnipotence of Allah.',
      dateAdded: DateTime.now(),
    ),
  ];

  Future<void> _onLoadTafseer(LoadTafseerEvent event, Emitter<TafseerState> emit) async {
    emit(state.copyWith(status: TafseerStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final tafseer = _allTafseers.firstWhere(
        (t) => t.surahNumber == event.surahNumber && t.ayahNumber == event.ayahNumber,
        orElse: () => _createDefaultTafseer(event.surahNumber, event.ayahNumber),
      );
      emit(state.copyWith(
        currentTafseer: tafseer,
        status: TafseerStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TafseerStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadAllTafseers(LoadAllTafseersEvent event, Emitter<TafseerState> emit) async {
    emit(state.copyWith(status: TafseerStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(
        tafseers: _allTafseers,
        status: TafseerStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TafseerStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onSearchTafseer(SearchTafseerEvent event, Emitter<TafseerState> emit) async {
    emit(state.copyWith(status: TafseerStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final results = _allTafseers
          .where((t) =>
              t.englishTranslation.toLowerCase().contains(event.query.toLowerCase()) ||
              t.moralLesson.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(state.copyWith(
        tafseers: results,
        status: TafseerStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TafseerStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onChangeTafseerStyle(ChangeTafseerStyleEvent event, Emitter<TafseerState> emit) async {
    emit(state.copyWith(currentStyle: event.style));
  }

  Future<void> _onSaveTafseerNote(SaveTafseerNoteEvent event, Emitter<TafseerState> emit) async {
    try {
      if (state.currentTafseer != null) {
        final updatedTafseer = state.currentTafseer!.copyWith(userNote: event.note);
        emit(state.copyWith(currentTafseer: updatedTafseer));
      }
    } catch (e) {
      emit(state.copyWith(
        status: TafseerStatus.error,
        error: e.toString(),
      ));
    }
  }

  TafseerExplanation _createDefaultTafseer(int surah, int ayah) {
    return TafseerExplanation(
      surahNumber: surah,
      ayahNumber: ayah,
      arabicText: 'Surah $surah:$ayah',
      englishTranslation: 'Verse from Surah $surah',
      classicalTafseer: 'Classical interpretation would go here.',
      modernInterpretation: 'Modern interpretation for this verse.',
      historicalContext: 'Historical context for Surah $surah.',
      moralLesson: 'Moral lesson from this verse.',
      dateAdded: DateTime.now(),
    );
  }
}
