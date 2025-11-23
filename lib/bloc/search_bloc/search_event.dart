part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchQueryEvent extends SearchEvent {
  final String query;
  
  const SearchQueryEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ClearSearchEvent extends SearchEvent {
  const ClearSearchEvent();

  @override
  List<Object> get props => [];
}
