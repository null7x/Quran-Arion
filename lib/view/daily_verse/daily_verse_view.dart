import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/daily_verse_bloc/daily_verse_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';

class DailyVerseView extends StatefulWidget {
  const DailyVerseView({Key? key}) : super(key: key);

  @override
  State<DailyVerseView> createState() => _DailyVerseViewState();
}

class _DailyVerseViewState extends State<DailyVerseView> {
  @override
  void initState() {
    super.initState();
    context.read<DailyVerseBloc>().add(const GetDailyVerseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueBackground,
      appBar: AppBar(
        title: const Text('Verse of the Day'),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<DailyVerseBloc, DailyVerseState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFD4AF37),
              ),
            );
          }

          if (state.verse == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.book,
                    size: 80,
                    color: AppColors.blueShade,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No verse available',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.lightShadowColor,
                        ),
                  ),
                ],
              ),
            );
          }

          final verse = state.verse!;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Arabic Text Card
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.blueShade, AppColors.backgroundColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      '${verse.surahName} - ${verse.ayahNumber}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.lightShadowColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      verse.arabicText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE8D5B7),
                        height: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // English Translation
              _buildTranslationCard(
                context,
                'English Translation',
                verse.englishTranslation,
              ),
              const SizedBox(height: 16),

              // Russian Translation
              _buildTranslationCard(
                context,
                'Russian Translation',
                verse.russianTranslation,
              ),
              const SizedBox(height: 16),

              // Explanation
              _buildExplanationCard(context, verse.explanation),
              const SizedBox(height: 24),

              // Share Button
              ElevatedButton.icon(
                onPressed: () {
                  context.read<DailyVerseBloc>().add(
                        ShareVerseEvent(verse.arabicText),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Verse shared!'),
                      backgroundColor: Color(0xFFD4AF37),
                    ),
                  );
                },
                icon: const Icon(Icons.share),
                label: const Text('Share Verse'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueShade,
                  foregroundColor: AppColors.lightShadowColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<DailyVerseBloc>().add(const GetDailyVerseEvent());
        },
        backgroundColor: AppColors.blueShade,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildTranslationCard(
    BuildContext context,
    String title,
    String text,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blueShade, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.blueShade,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.lightShadowColor,
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationCard(BuildContext context, String explanation) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blueShade, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explanation',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.blueShade,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            explanation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.lightShadowColor,
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}
