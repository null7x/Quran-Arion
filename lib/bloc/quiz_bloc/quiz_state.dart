enum QuizStatus { initial, loading, inProgress, completed, error }

class QuizQuestion {
  final int id;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String category;
  final String explanation;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.category,
    required this.explanation,
  });
}

class QuizResult {
  final int questionId;
  final String selectedAnswer;
  final bool isCorrect;
  final DateTime answeredAt;

  QuizResult({
    required this.questionId,
    required this.selectedAnswer,
    required this.isCorrect,
    required this.answeredAt,
  });
}

class QuizState {
  final List<QuizQuestion> questions;
  final List<QuizResult> results;
  final int currentQuestionIndex;
  final QuizStatus status;
  final String? error;
  final int correctAnswers;
  final int totalQuestions;

  QuizState({
    this.questions = const [],
    this.results = const [],
    this.currentQuestionIndex = 0,
    this.status = QuizStatus.initial,
    this.error,
    this.correctAnswers = 0,
    this.totalQuestions = 0,
  });

  QuizState copyWith({
    List<QuizQuestion>? questions,
    List<QuizResult>? results,
    int? currentQuestionIndex,
    QuizStatus? status,
    String? error,
    int? correctAnswers,
    int? totalQuestions,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      results: results ?? this.results,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      status: status ?? this.status,
      error: error ?? this.error,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      totalQuestions: totalQuestions ?? this.totalQuestions,
    );
  }

  double get scorePercentage =>
      totalQuestions == 0 ? 0 : (correctAnswers / totalQuestions) * 100;

  QuizQuestion? get currentQuestion =>
      currentQuestionIndex < questions.length ? questions[currentQuestionIndex] : null;

  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;

  bool get isFirstQuestion => currentQuestionIndex == 0;
}
