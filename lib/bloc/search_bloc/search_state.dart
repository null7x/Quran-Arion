part of 'search_bloc.dart';

class SearchResult {
  final String type; // 'surah' or 'qari'
  final int id;
  final String name;
  final String? subtitle;
  final String? imageUrl;

  SearchResult({
    required this.type,
    required this.id,
    required this.name,
    this.subtitle,
    this.imageUrl,
  });
}

class SearchState extends Equatable {
  final List<SearchResult> results;
  final String query;
  final bool isLoading;

  const SearchState({
    this.results = const [],
    this.query = '',
    this.isLoading = false,
  });

  SearchState copyWith({
    List<SearchResult>? results,
    String? query,
    bool? isLoading,
  }) {
    return SearchState(
      results: results ?? this.results,
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [results, query, isLoading];
}
