import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/tafseer_bloc/tafseer_bloc.dart';
import '../../bloc/tafseer_bloc/tafseer_event.dart';
import '../../bloc/tafseer_bloc/tafseer_state.dart';
import '../../res/app_colors.dart';

class TafseerView extends StatefulWidget {
  const TafseerView({Key? key}) : super(key: key);

  @override
  State<TafseerView> createState() => _TafseerViewState();
}

class _TafseerViewState extends State<TafseerView> {
  final TextEditingController _surahController = TextEditingController();
  final TextEditingController _ayahController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TafseerBloc>().add(LoadAllTafseersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tafseer (Quran Explanation)'),
        backgroundColor: AppColors.darkGreen,
        elevation: 0,
      ),
      body: BlocBuilder<TafseerBloc, TafseerState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _surahController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Surah #',
                                border:
                                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _ayahController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Ayah #',
                                border:
                                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkGreen,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            final surah = int.tryParse(_surahController.text) ?? 1;
                            final ayah = int.tryParse(_ayahController.text) ?? 1;
                            context.read<TafseerBloc>().add(
                                  LoadTafseerEvent(
                                    surahNumber: surah,
                                    ayahNumber: ayah,
                                  ),
                                );
                          },
                          child: const Text('Load Tafseer'),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.currentTafseer != null) ...[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Surah ${state.currentTafseer!.surahNumber}:${state.currentTafseer!.ayahNumber}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkGreen,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.currentTafseer!.arabicText,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                height: 2,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 16),
                            _buildTafseerSection(
                              'Translation',
                              state.currentTafseer!.englishTranslation,
                            ),
                            const SizedBox(height: 16),
                            _buildTafseerSection(
                              'Classical Tafseer',
                              state.currentTafseer!.classicalTafseer,
                            ),
                            const SizedBox(height: 16),
                            _buildTafseerSection(
                              'Modern Interpretation',
                              state.currentTafseer!.modernInterpretation,
                            ),
                            const SizedBox(height: 16),
                            _buildTafseerSection(
                              'Historical Context',
                              state.currentTafseer!.historicalContext,
                            ),
                            const SizedBox(height: 16),
                            _buildTafseerSection(
                              'Moral Lesson',
                              state.currentTafseer!.moralLesson,
                            ),
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 16),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Add your notes...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                              ),
                              maxLines: 3,
                              onChanged: (value) {
                                context.read<TafseerBloc>().add(
                                      SaveTafseerNoteEvent(
                                        surahNumber: state.currentTafseer!.surahNumber,
                                        ayahNumber: state.currentTafseer!.ayahNumber,
                                        note: value,
                                      ),
                                    );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ] else if (state.status == TafseerStatus.loading)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  )
                else
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Select a Surah and Ayah to view Tafseer'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTafseerSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _surahController.dispose();
    _ayahController.dispose();
    super.dispose();
  }
}
