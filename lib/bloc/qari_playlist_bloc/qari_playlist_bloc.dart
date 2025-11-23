import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'qari_playlist_event.dart';
part 'qari_playlist_state.dart';

class QariPlaylistBloc extends Bloc<QariPlaylistEvent, QariPlaylistState> {
  QariPlaylistBloc() : super(const QariPlaylistState()) {
    on<GetQariPlaylistsEvent>(_onGetQariPlaylists);
    on<SelectQariEvent>(_onSelectQari);
    on<PlayQariSurahEvent>(_onPlayQariSurah);
    on<StopQariPlaybackEvent>(_onStopQariPlayback);
  }

  Future<void> _onGetQariPlaylists(
      GetQariPlaylistsEvent event, Emitter<QariPlaylistState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final qariPlaylists = [
        QariPlaylist(
          id: 1,
          name: 'Abdur-Rahman As-Sudais',
          biography: 'The Grand Imam of Masjid Al-Haram, known for his beautiful recitation.',
          country: 'Saudi Arabia',
          imageUrl: 'assets/images/qaris/abdur_rahman_as_sudais.png',
        ),
        QariPlaylist(
          id: 2,
          name: 'Muhammad Al-Tablawi',
          biography: 'One of the most famous Egyptian reciters, loved by millions worldwide.',
          country: 'Egypt',
          imageUrl: 'assets/images/qaris/muhammad_al_tablawi.png',
        ),
        QariPlaylist(
          id: 3,
          name: 'Abdul Basit Abdul Samad',
          biography: 'The legendary reciter, considered one of the greatest Quranic scholars.',
          country: 'Egypt',
          imageUrl: 'assets/images/qaris/abdul_basit.png',
        ),
        QariPlaylist(
          id: 4,
          name: 'Mishari Alafasy',
          biography: 'Modern Kuwaiti reciter known for emotional and melodious recitation.',
          country: 'Kuwait',
          imageUrl: 'assets/images/qaris/mishari_alafasy.png',
        ),
        QariPlaylist(
          id: 5,
          name: 'Saad Al-Ghamdi',
          biography: 'Saudi Arabian reciter with a unique style and powerful voice.',
          country: 'Saudi Arabia',
          imageUrl: 'assets/images/qaris/saad_al_ghamdi.png',
        ),
        QariPlaylist(
          id: 6,
          name: 'Maher Al-Muaiqly',
          biography: 'Distinguished Saudi reciter known for precise and clear recitation.',
          country: 'Saudi Arabia',
          imageUrl: 'assets/images/qaris/maher_al_muaiqly.png',
        ),
        QariPlaylist(
          id: 7,
          name: 'Fatih Al-Sisi',
          biography: 'Egyptian reciter with a melodious and soothing voice.',
          country: 'Egypt',
          imageUrl: 'assets/images/qaris/fatih_al_sisi.png',
        ),
        QariPlaylist(
          id: 8,
          name: 'Ahmed Al-Ajmi',
          biography: 'Saudi reciter known for his powerful and moving recitation style.',
          country: 'Saudi Arabia',
          imageUrl: 'assets/images/qaris/ahmed_al_ajmi.png',
        ),
      ];

      emit(state.copyWith(
        qariPlaylists: qariPlaylists,
        status: Status.complete,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onSelectQari(
      SelectQariEvent event, Emitter<QariPlaylistState> emit) async {
    emit(state.copyWith(
      selectedQariName: event.qariName,
      selectedQariId: event.qariId,
    ));
  }

  Future<void> _onPlayQariSurah(
      PlayQariSurahEvent event, Emitter<QariPlaylistState> emit) async {
    emit(state.copyWith(
      playingQariId: state.selectedQariId,
      playingSurahNumber: event.surahNumber,
      playingSurahName: event.surahName,
      isPlaying: true,
    ));
  }

  Future<void> _onStopQariPlayback(
      StopQariPlaybackEvent event, Emitter<QariPlaylistState> emit) async {
    emit(state.copyWith(
      isPlaying: false,
      playingQariId: null,
      playingSurahNumber: null,
      playingSurahName: null,
    ));
  }
}
