abstract class TasbeehEvent {}

class LoadTasbeehEvent extends TasbeehEvent {}

class IncrementTasbeehCounterEvent extends TasbeehEvent {
  final int taskbeehId;
  IncrementTasbeehCounterEvent(this.taskbeehId);
}

class ResetTasbeehCounterEvent extends TasbeehEvent {
  final int tasbeehId;
  ResetTasbeehCounterEvent(this.tasbeehId);
}

class AddCustomTasbeehEvent extends TasbeehEvent {
  final String tasbeehText;
  final int targetCount;
  AddCustomTasbeehEvent({required this.tasbeehText, required this.targetCount});
}

class RemoveCustomTasbeehEvent extends TasbeehEvent {
  final int tasbeehId;
  RemoveCustomTasbeehEvent(this.tasbeehId);
}

class CompleteTasbeehEvent extends TasbeehEvent {
  final int tasbeehId;
  CompleteTasbeehEvent(this.tasbeehId);
}

class GetTasbeehHistoryEvent extends TasbeehEvent {}
