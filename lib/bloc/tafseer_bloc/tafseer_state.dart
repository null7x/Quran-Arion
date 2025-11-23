enum TafseerStatus { initial, loading, success, error }

class TafseerExplanation {
  final int surahNumber;
  final int ayahNumber;
  final String arabicText;
  final String englishTranslation;
  final String classicalTafseer;
  final String modernInterpretation;
  final String historicalContext;
  final String moralLesson;
  final String? userNote;
  final DateTime dateAdded;

  TafseerExplanation({
    required this.surahNumber,
    required this.ayahNumber,
    required this.arabicText,
    required this.englishTranslation,
    required this.classicalTafseer,
    required this.modernInterpretation,
    required this.historicalContext,
    required this.moralLesson,
    this.userNote,
    required this.dateAdded,
  });

  TafseerExplanation copyWith({
    int? surahNumber,
    int? ayahNumber,
    String? arabicText,
    String? englishTranslation,
    String? classicalTafseer,
    String? modernInterpretation,
    String? historicalContext,
    String? moralLesson,
    String? userNote,
    DateTime? dateAdded,
  }) {
    return TafseerExplanation(
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      arabicText: arabicText ?? this.arabicText,
      englishTranslation: englishTranslation ?? this.englishTranslation,
      classicalTafseer: classicalTafseer ?? this.classicalTafseer,
      modernInterpretation: modernInterpretation ?? this.modernInterpretation,
      historicalContext: historicalContext ?? this.historicalContext,
      moralLesson: moralLesson ?? this.moralLesson,
      userNote: userNote ?? this.userNote,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }
}

class TafseerState {
  final List<TafseerExplanation> tafseers;
  final TafseerExplanation? currentTafseer;
  final TafseerStatus status;
  final String? error;
  final String currentStyle;

  TafseerState({
    this.tafseers = const [],
    this.currentTafseer,
    this.status = TafseerStatus.initial,
    this.error,
    this.currentStyle = 'classical',
  });

  TafseerState copyWith({
    List<TafseerExplanation>? tafseers,
    TafseerExplanation? currentTafseer,
    TafseerStatus? status,
    String? error,
    String? currentStyle,
  }) {
    return TafseerState(
      tafseers: tafseers ?? this.tafseers,
      currentTafseer: currentTafseer ?? this.currentTafseer,
      status: status ?? this.status,
      error: error ?? this.error,
      currentStyle: currentStyle ?? this.currentStyle,
    );
  }
}
