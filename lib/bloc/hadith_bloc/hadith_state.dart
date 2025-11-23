enum HadithStatus { initial, loading, success, error }

class Hadith {
  final int id;
  final String text;
  final String narrator;
  final String category;
  final String explanation;
  final DateTime dateAdded;

  Hadith({
    required this.id,
    required this.text,
    required this.narrator,
    required this.category,
    required this.explanation,
    required this.dateAdded,
  });

  Hadith copyWith({
    int? id,
    String? text,
    String? narrator,
    String? category,
    String? explanation,
    DateTime? dateAdded,
  }) {
    return Hadith(
      id: id ?? this.id,
      text: text ?? this.text,
      narrator: narrator ?? this.narrator,
      category: category ?? this.category,
      explanation: explanation ?? this.explanation,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }
}

class HadithState {
  final List<Hadith> hadiths;
  final List<Hadith> favorites;
  final HadithStatus status;
  final String? error;
  final String? selectedCategory;

  HadithState({
    this.hadiths = const [],
    this.favorites = const [],
    this.status = HadithStatus.initial,
    this.error,
    this.selectedCategory,
  });

  HadithState copyWith({
    List<Hadith>? hadiths,
    List<Hadith>? favorites,
    HadithStatus? status,
    String? error,
    String? selectedCategory,
  }) {
    return HadithState(
      hadiths: hadiths ?? this.hadiths,
      favorites: favorites ?? this.favorites,
      status: status ?? this.status,
      error: error ?? this.error,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
