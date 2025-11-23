enum TasbeehStatus { initial, loading, success, error }

class Tasbeeh {
  final int id;
  final String text;
  final int currentCount;
  final int targetCount;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;
  final bool isCustom;

  Tasbeeh({
    required this.id,
    required this.text,
    required this.currentCount,
    required this.targetCount,
    required this.isCompleted,
    required this.createdAt,
    this.completedAt,
    this.isCustom = false,
  });

  Tasbeeh copyWith({
    int? id,
    String? text,
    int? currentCount,
    int? targetCount,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? completedAt,
    bool? isCustom,
  }) {
    return Tasbeeh(
      id: id ?? this.id,
      text: text ?? this.text,
      currentCount: currentCount ?? this.currentCount,
      targetCount: targetCount ?? this.targetCount,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      isCustom: isCustom ?? this.isCustom,
    );
  }

  double get progress => targetCount == 0 ? 0 : (currentCount / targetCount);
}

class TasbeehState {
  final List<Tasbeeh> tasbeehs;
  final List<Tasbeeh> completedTasbeehs;
  final TasbeehStatus status;
  final String? error;
  final int totalCompletions;

  TasbeehState({
    this.tasbeehs = const [],
    this.completedTasbeehs = const [],
    this.status = TasbeehStatus.initial,
    this.error,
    this.totalCompletions = 0,
  });

  TasbeehState copyWith({
    List<Tasbeeh>? tasbeehs,
    List<Tasbeeh>? completedTasbeehs,
    TasbeehStatus? status,
    String? error,
    int? totalCompletions,
  }) {
    return TasbeehState(
      tasbeehs: tasbeehs ?? this.tasbeehs,
      completedTasbeehs: completedTasbeehs ?? this.completedTasbeehs,
      status: status ?? this.status,
      error: error ?? this.error,
      totalCompletions: totalCompletions ?? this.totalCompletions,
    );
  }
}
