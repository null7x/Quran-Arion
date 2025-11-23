import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quran_arion/bloc/album_bloc/album_bloc.dart';
import 'package:quran_arion/bloc/home_bloc/home_event.dart';
import 'package:quran_arion/utils/translations.dart';
import 'package:quran_arion/providers/app_language_provider.dart';
import 'package:quran_arion/view/common_widget/app_bar.dart';
import 'package:quran_arion/view/common_widget/loading_files.dart';
import 'package:quran_arion/view/home/components/home_top_box.dart';
import 'package:quran_arion/view/home/components/recently_played_list.dart';
import 'package:quran_arion/view/home/components/songs.dart';

import '../../bloc/home_bloc/home_bloc.dart';
import '../../bloc/home_bloc/home_state.dart';
import 'components/home_bottom_player.dart';
import 'components/home_foler_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>()..add(GetFavSongEvent())..add(GetSongEvent());
  }

  @override
  Widget build(BuildContext context) {
    var s = context.read<AlbumBloc>().state;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const CustomAppBar(),
                const SizedBox(
                  height: 40,
                ),
                const HomeIntroBox(),
                const RecentlyPlayedList(),
                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) => current.songListStatus!=previous.songListStatus,
                    builder: (context, loadingState) {
                      if(loadingState.songListStatus==Status.complete){
                        if (loadingState.songList.isEmpty) {
                          return HomeFolderList(
                            state: s,
                          );
                        } else {
                          return const SongsList();
                        }
                      }
                      return Column(
                        children: [
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              Text(
                                Translations.get('library'),
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                // onTap: () => Utils.go(context: context, screen: AllMusicAlbum()),

                                child: Text(
                                  Translations.get('seeAll'),
                                  style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          const Expanded(child: FilesLoading()),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
             const HomeBottomPlayer(),

          ],
        ),
      ),
    ));
  }
}
