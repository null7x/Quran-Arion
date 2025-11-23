part of 'duas_bloc.dart';

abstract class DuasEvent extends Equatable {
  const DuasEvent();

  @override
  List<Object> get props => [];
}

class GetDuasEvent extends DuasEvent {
  final String? category;
  
  const GetDuasEvent({this.category});

  @override
  List<Object> get props => [category ?? ''];
}

class GetCategoriesEvent extends DuasEvent {
  const GetCategoriesEvent();

  @override
  List<Object> get props => [];
}

class SearchDuasEvent extends DuasEvent {
  final String query;
  
  const SearchDuasEvent(this.query);

  @override
  List<Object> get props => [query];
}
