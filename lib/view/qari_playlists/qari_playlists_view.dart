import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/qari_playlist_bloc/qari_playlist_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';

class QariPlaylistsView extends StatefulWidget {
  const QariPlaylistsView({super.key});

  @override
  State<QariPlaylistsView> createState() => _QariPlaylistsViewState();
}

class _QariPlaylistsViewState extends State<QariPlaylistsView> {
  @override
  void initState() {
    super.initState();
    context.read<QariPlaylistBloc>().add(const GetQariPlaylistsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Quran Reciters',
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
          child: BlocBuilder<QariPlaylistBloc, QariPlaylistState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: blueShade,
                  ),
                );
              }

              if (state.qariPlaylists.isEmpty) {
                return Center(
                  child: Text(
                    'No reciters available',
                    style: TextStyle(
                      color: lightShadowColor,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: state.qariPlaylists.length,
                itemBuilder: (context, index) {
                  final qari = state.qariPlaylists[index];
                  final isSelected = state.selectedQariId == qari.id;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isSelected
                            ? [blueShade.withOpacity(0.8), blueShade.withOpacity(0.6)]
                            : [shadowColor, blueBackground],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? blueShade.withOpacity(0.5)
                              : Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        context.read<QariPlaylistBloc>().add(
                          SelectQariEvent(qari.name, qari.id),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Selected: ${qari.name}'),
                            backgroundColor: blueShade,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Qari Avatar Circle
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        blueShade,
                                        blueShade.withOpacity(0.6),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      color: lightShadowColor,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                // Qari Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        qari.name,
                                        style: TextStyle(
                                          color: lightShadowColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: blueShade,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            qari.country,
                                            style: TextStyle(
                                              color: lightShadowColor
                                                  .withOpacity(0.7),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Selection Indicator
                                if (isSelected)
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: lightShadowColor.withOpacity(0.2),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: blueShade,
                                      size: 20,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            // Biography
                            Text(
                              qari.biography,
                              style: TextStyle(
                                color: lightShadowColor.withOpacity(0.8),
                                fontSize: 13,
                                height: 1.5,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                            // Action Button
                            ElevatedButton(
                              onPressed: isSelected
                                  ? () {
                                      // Show Surahs for this Qari
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Load Surahs by ${qari.name}'),
                                          backgroundColor: blueShade,
                                        ),
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: blueShade,
                                disabledBackgroundColor:
                                    blueShade.withOpacity(0.3),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                isSelected ? 'Browse Surahs' : 'Select',
                                style: TextStyle(
                                  color: isSelected
                                      ? lightShadowColor
                                      : lightShadowColor.withOpacity(0.5),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
