import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/quiz_bloc/quiz_bloc.dart';
import '../../bloc/quiz_bloc/quiz_event.dart';
import '../../bloc/quiz_bloc/quiz_state.dart';
import '../../res/app_colors.dart';

class QuizView extends StatefulWidget {
  const QuizView({Key? key}) : super(key: key);

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  @override
  void initState() {
    super.initState();
    context.read<QuizBloc>().add(LoadQuizCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Islamic Quiz'),
        backgroundColor: AppColors.darkGreen,
        elevation: 0,
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state.status == QuizStatus.inProgress && state.currentQuestion != null) {
            return _buildQuizScreen(context, state);
          }

          if (state.status == QuizStatus.completed) {
            return _buildResultsScreen(context, state);
          }

          return _buildCategorySelectionScreen(context);
        },
      ),
    );
  }

  Widget _buildCategorySelectionScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Islamic Knowledge Quiz',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGreen,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Test your knowledge of Islam',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ...['Quran', 'Islamic Basics', 'Islamic History'].map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkGreen,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          context.read<QuizBloc>().add(LoadQuizEvent(category: category));
                        },
                        child: Text(
                          category,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizScreen(BuildContext context, QuizState state) {
    final question = state.currentQuestion!;
    final progress = (state.currentQuestionIndex + 1) / state.totalQuestions;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
            ),
            const SizedBox(height: 16),
            Text(
              'Question ${state.currentQuestionIndex + 1}/${state.totalQuestions}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              question.question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            ...question.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isSelected = state.results.any(
                (r) => r.questionId == question.id && r.selectedAnswer == option,
              );

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () {
                    context.read<QuizBloc>().add(
                          SubmitAnswerEvent(
                            questionId: question.id,
                            selectedAnswer: option,
                          ),
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? AppColors.darkGreen : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected ? AppColors.darkGreen.withOpacity(0.1) : Colors.white,
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? AppColors.darkGreen : Colors.black87,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: !state.isFirstQuestion
                      ? () {
                          context.read<QuizBloc>().add(PreviousQuestionEvent());
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                  ),
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: state.isLastQuestion
                      ? () {
                          context.read<QuizBloc>().add(SubmitQuizEvent());
                        }
                      : () {
                          context.read<QuizBloc>().add(NextQuestionEvent());
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkGreen,
                  ),
                  child: Text(state.isLastQuestion ? 'Finish' : 'Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsScreen(BuildContext context, QuizState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            const Icon(
              Icons.check_circle,
              size: 80,
              color: AppColors.darkGreen,
            ),
            const SizedBox(height: 24),
            const Text(
              'Quiz Completed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.darkGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    '${state.correctAnswers}/${state.totalQuestions}',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${state.scorePercentage.toStringAsFixed(1)}% Correct',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.darkGreen,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  context.read<QuizBloc>().add(ResetQuizEvent());
                },
                child: const Text('Take Another Quiz'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
