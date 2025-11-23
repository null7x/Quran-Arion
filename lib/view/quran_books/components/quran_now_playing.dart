import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/quran_bloc/quran_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';

class QuranNowPlayingWidget extends StatelessWidget {
  const QuranNowPlayingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranBloc, QuranState>(
      builder: (context, state) {
        if (!state.isPlaying || state.playingSurahName == null) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                blueShade,
                blueShade.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: blueShade.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              // Playing indicator
              AnimatedBuilder(
                animation: AlwaysStoppedAnimation(0.0),
                builder: (context, child) {
                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightShadowColor.withOpacity(0.2),
                    ),
                    child: Icon(
                      Icons.music_note,
                      color: lightShadowColor,
                      size: 28,
                    ),
                  );
                },
              ),
              const SizedBox(width: 15),
              // Surah info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Now Playing',
                      style: TextStyle(
                        color: lightShadowColor.withOpacity(0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      state.playingSurahName ?? '',
                      style: TextStyle(
                        color: lightShadowColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Stop button
              IconButton(
                onPressed: () {
                  context.read<QuranBloc>().add(const StopQuranPlaybackEvent());
                },
                icon: Icon(
                  Icons.close,
                  color: lightShadowColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
