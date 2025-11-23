part of 'quran_bloc.dart';

abstract class QuranEvent extends Equatable {
  const QuranEvent();

  @override
  List<Object> get props => [];
}

class GetQuranBooksEvent extends QuranEvent {
  const GetQuranBooksEvent();

  @override
  List<Object> get props => [];
}

class SelectQuranBookEvent extends QuranEvent {
  final String bookName;
  const SelectQuranBookEvent(this.bookName);

  @override
  List<Object> get props => [bookName];
}
