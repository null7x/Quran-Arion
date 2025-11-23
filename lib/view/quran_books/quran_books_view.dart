import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/quran_bloc/quran_bloc.dart';
import 'package:quran_arion/bloc/player_bloc/player_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';

class QuranBooksView extends StatefulWidget {
  const QuranBooksView({super.key});

  @override
  State<QuranBooksView> createState() => _QuranBooksViewState();
}

class _QuranBooksViewState extends State<QuranBooksView> {
  @override
  void initState() {
    super.initState();
    context.read<QuranBloc>().add(const GetQuranBooksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Holy Quran Books',
          style: TextStyle(
            color: lightShadowColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: BlocBuilder<QuranBloc, QuranState>(
            builder: (context, state) {
              if (state.quranStatus == Status.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: blueShade,
                  ),
                );
              }

              if (state.quranBooks.isEmpty) {
                return Center(
                  child: Text(
                    'No Quran books available',
                    style: TextStyle(
                      color: lightShadowColor,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: state.quranBooks.length,
                itemBuilder: (context, index) {
                  final book = state.quranBooks[index];
                  final surahNumber = index + 1;
                  final isPlaying = state.playingSurahNumber == surahNumber;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isPlaying
                            ? [blueShade.withOpacity(0.7), blueShade.withOpacity(0.5)]
                            : [shadowColor, blueBackground],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: isPlaying
                              ? blueShade.withOpacity(0.5)
                              : Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        if (isPlaying) {
                          // Stop playing
                          context.read<QuranBloc>().add(const StopQuranPlaybackEvent());
                        } else {
                          // Play Surah
                          context.read<QuranBloc>().add(
                            PlayQuranSurahEvent(surahNumber, book),
                          );
                          
                          // Show confirmation
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Now playing: $book'),
                              backgroundColor: blueShade,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            // Surah Number Circle
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: blueShade,
                              ),
                              child: Center(
                                child: Text(
                                  surahNumber.toString(),
                                  style: TextStyle(
                                    color: backgroundColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Book Name
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book,
                                    style: TextStyle(
                                      color: lightShadowColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Chapter $surahNumber of the Holy Quran',
                                    style: TextStyle(
                                      color: lightShadowColor.withOpacity(0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (isPlaying)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        '▶ Now Playing',
                                        style: TextStyle(
                                          color: blueShade,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            // Play/Stop Icon
                            AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: AlwaysStoppedAnimation(isPlaying ? 1.0 : 0.0),
                              color: blueShade,
                              size: 32,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
