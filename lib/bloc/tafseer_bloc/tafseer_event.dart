abstract class TafseerEvent {}

class LoadTafseerEvent extends TafseerEvent {
  final int surahNumber;
  final int ayahNumber;
  LoadTafseerEvent({required this.surahNumber, required this.ayahNumber});
}

class LoadAllTafseersEvent extends TafseerEvent {}

class SearchTafseerEvent extends TafseerEvent {
  final String query;
  SearchTafseerEvent(this.query);
}

class ChangeTafseerStyleEvent extends TafseerEvent {
  final String style;
  ChangeTafseerStyleEvent(this.style);
}

class SaveTafseerNoteEvent extends TafseerEvent {
  final int surahNumber;
  final int ayahNumber;
  final String note;
  SaveTafseerNoteEvent({
    required this.surahNumber,
    required this.ayahNumber,
    required this.note,
  });
}
