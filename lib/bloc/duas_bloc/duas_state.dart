part of 'duas_bloc.dart';

class Dua {
  final int id;
  final String arabicText;
  final String englishTranslation;
  final String russianTranslation;
  final String category;
  final String? benefits;

  Dua({
    required this.id,
    required this.arabicText,
    required this.englishTranslation,
    required this.russianTranslation,
    required this.category,
    this.benefits,
  });
}

class DuasState extends Equatable {
  final List<Dua> duas;
  final List<String> categories;
  final String? selectedCategory;
  final Status status;

  const DuasState({
    this.duas = const [],
    this.categories = const [],
    this.selectedCategory,
    this.status = Status.initial,
  });

  DuasState copyWith({
    List<Dua>? duas,
    List<String>? categories,
    String? selectedCategory,
    Status? status,
  }) {
    return DuasState(
      duas: duas ?? this.duas,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [duas, categories, selectedCategory, status];
}

enum Status { initial, loading, complete, error }
