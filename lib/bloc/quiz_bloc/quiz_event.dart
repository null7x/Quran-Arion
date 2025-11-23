abstract class QuizEvent {}

class LoadQuizEvent extends QuizEvent {
  final String? category;
  LoadQuizEvent({this.category});
}

class SubmitAnswerEvent extends QuizEvent {
  final int questionId;
  final String selectedAnswer;
  SubmitAnswerEvent({required this.questionId, required this.selectedAnswer});
}

class NextQuestionEvent extends QuizEvent {}

class PreviousQuestionEvent extends QuizEvent {}

class ResetQuizEvent extends QuizEvent {}

class SubmitQuizEvent extends QuizEvent {}

class LoadQuizCategoriesEvent extends QuizEvent {}
