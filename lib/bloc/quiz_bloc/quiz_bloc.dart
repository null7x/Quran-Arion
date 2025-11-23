import 'package:flutter_bloc/flutter_bloc.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizState()) {
    on<LoadQuizEvent>(_onLoadQuiz);
    on<SubmitAnswerEvent>(_onSubmitAnswer);
    on<NextQuestionEvent>(_onNextQuestion);
    on<PreviousQuestionEvent>(_onPreviousQuestion);
    on<ResetQuizEvent>(_onResetQuiz);
    on<SubmitQuizEvent>(_onSubmitQuiz);
    on<LoadQuizCategoriesEvent>(_onLoadCategories);
  }

  final List<QuizQuestion> _allQuestions = [
    QuizQuestion(
      id: 1,
      question: 'How many surahs are in the Quran?',
      options: ['100', '114', '120', '130'],
      correctAnswer: '114',
      category: 'Quran',
      explanation: 'The Quran contains exactly 114 Surahs (chapters).',
    ),
    QuizQuestion(
      id: 2,
      question: 'How many pillars of Islam are there?',
      options: ['3', '4', '5', '6'],
      correctAnswer: '5',
      category: 'Islamic Basics',
      explanation: 'The Five Pillars of Islam are the foundation of Muslim life.',
    ),
    QuizQuestion(
      id: 3,
      question: 'In which year was the Prophet Muhammad born?',
      options: ['570 CE', '571 CE', '569 CE', '572 CE'],
      correctAnswer: '570 CE',
      category: 'Islamic History',
      explanation: 'Prophet Muhammad was born in 570 CE in Mecca.',
    ),
    QuizQuestion(
      id: 4,
      question: 'What is the holy month of fasting in Islam?',
      options: ['Hajj', 'Ramadan', 'Shawwal', 'Muharram'],
      correctAnswer: 'Ramadan',
      category: 'Islamic Basics',
      explanation: 'Ramadan is the ninth month of the Islamic calendar, dedicated to fasting.',
    ),
    QuizQuestion(
      id: 5,
      question: 'Which Surah is the longest in the Quran?',
      options: ['Al-Fatiha', 'Al-Baqarah', 'Al-Imran', 'An-Nisa'],
      correctAnswer: 'Al-Baqarah',
      category: 'Quran',
      explanation: 'Surah Al-Baqarah (The Cow) is the longest surah with 286 verses.',
    ),
  ];

  Future<void> _onLoadQuiz(LoadQuizEvent event, Emitter<QuizState> emit) async {
    emit(state.copyWith(status: QuizStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final questions = event.category == null
          ? _allQuestions
          : _allQuestions.where((q) => q.category == event.category).toList();
      emit(state.copyWith(
        questions: questions,
        totalQuestions: questions.length,
        currentQuestionIndex: 0,
        status: QuizStatus.inProgress,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: QuizStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onSubmitAnswer(SubmitAnswerEvent event, Emitter<QuizState> emit) async {
    try {
      final question = state.questions.firstWhere((q) => q.id == event.questionId);
      final isCorrect = event.selectedAnswer == question.correctAnswer;
      final newResults = [...state.results];
      newResults.add(QuizResult(
        questionId: event.questionId,
        selectedAnswer: event.selectedAnswer,
        isCorrect: isCorrect,
        answeredAt: DateTime.now(),
      ));
      emit(state.copyWith(
        results: newResults,
        correctAnswers: isCorrect ? state.correctAnswers + 1 : state.correctAnswers,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: QuizStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onNextQuestion(NextQuestionEvent event, Emitter<QuizState> emit) async {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      emit(state.copyWith(currentQuestionIndex: state.currentQuestionIndex + 1));
    }
  }

  Future<void> _onPreviousQuestion(PreviousQuestionEvent event, Emitter<QuizState> emit) async {
    if (state.currentQuestionIndex > 0) {
      emit(state.copyWith(currentQuestionIndex: state.currentQuestionIndex - 1));
    }
  }

  Future<void> _onResetQuiz(ResetQuizEvent event, Emitter<QuizState> emit) async {
    emit(QuizState());
  }

  Future<void> _onSubmitQuiz(SubmitQuizEvent event, Emitter<QuizState> emit) async {
    emit(state.copyWith(status: QuizStatus.completed));
  }

  Future<void> _onLoadCategories(LoadQuizCategoriesEvent event, Emitter<QuizState> emit) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final categories = _allQuestions.map((q) => q.category).toSet().toList();
      emit(state.copyWith(status: QuizStatus.inProgress));
    } catch (e) {
      emit(state.copyWith(
        status: QuizStatus.error,
        error: e.toString(),
      ));
    }
  }
}
