import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_arion/bloc/album_bloc/album_bloc.dart';
import 'package:quran_arion/bloc/boarding_bloc/boarding_bloc.dart';
import 'package:quran_arion/bloc/home_bloc/home_bloc.dart';
import 'package:quran_arion/bloc/player_bloc/player_bloc.dart';
import 'package:quran_arion/bloc/quran_bloc/quran_bloc.dart';
import 'package:quran_arion/bloc/qibla_bloc/qibla_bloc.dart';
import 'package:quran_arion/bloc/qari_playlist_bloc/qari_playlist_bloc.dart';
import 'package:quran_arion/bloc/prayer_times_bloc/prayer_times_bloc.dart';
import 'package:quran_arion/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:quran_arion/bloc/daily_verse_bloc/daily_verse_bloc.dart';
import 'package:quran_arion/bloc/search_bloc/search_bloc.dart';
import 'package:quran_arion/bloc/islamic_calendar_bloc/islamic_calendar_bloc.dart';
import 'package:quran_arion/bloc/duas_bloc/duas_bloc.dart';
import 'package:quran_arion/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:quran_arion/bloc/settings_bloc/settings_bloc.dart';
import 'package:quran_arion/bloc/bookmarks_bloc/bookmarks_bloc.dart';
import 'package:quran_arion/bloc/statistics_bloc/statistics_bloc.dart';
import 'package:quran_arion/bloc/hadith_bloc/hadith_bloc.dart';
import 'package:quran_arion/bloc/tafseer_bloc/tafseer_bloc.dart';
import 'package:quran_arion/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:quran_arion/bloc/notification_bloc/notification_bloc.dart';
import 'package:quran_arion/bloc/offline_mode_bloc/offline_bloc.dart';
import 'package:quran_arion/bloc/articles_bloc/articles_bloc.dart';
import 'package:quran_arion/bloc/tasbeeh_bloc/tasbeeh_bloc.dart';
import 'package:quran_arion/bloc/sharing_bloc/sharing_bloc.dart';
import 'package:quran_arion/db_helper/db_helper.dart';
import 'package:quran_arion/res/app_colors.dart';
import 'package:quran_arion/view/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:quran_arion/providers/app_language_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppLanguageProvider(),
      child: Consumer<AppLanguageProvider>(
        builder: (context, languageProvider, _) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => BoardingBLoc(pageController: PageController()),
              ),
              BlocProvider(
                create: (_) => HomeBloc(dbHelper: DbHelper()),
              ),
              BlocProvider(
                create: (_) => PlayerBloc(player: AudioPlayer()),
              ),
              BlocProvider(
                create: (_) => AlbumBloc(pageController: PageController()),
              ),
              BlocProvider(
                create: (_) => QuranBloc(),
              ),
              BlocProvider(
                create: (_) => QiblaBloc(),
              ),
              BlocProvider(
                create: (_) => QariPlaylistBloc(),
              ),
              BlocProvider(
                create: (_) => PrayerTimesBloc(),
              ),
              BlocProvider(
                create: (_) => FavoritesBloc(),
              ),
              BlocProvider(
                create: (_) => DailyVerseBloc(),
              ),
              BlocProvider(
                create: (_) => SearchBloc(),
              ),
              BlocProvider(
                create: (_) => IslamicCalendarBloc(),
              ),
              BlocProvider(
                create: (_) => DuasBloc(),
              ),
              BlocProvider(
                create: (_) => UserProfileBloc(),
              ),
              BlocProvider(
                create: (_) => SettingsBloc(),
              ),
              BlocProvider(
                create: (_) => BookmarksBloc(),
              ),
              BlocProvider(
                create: (_) => StatisticsBloc(),
              ),
              BlocProvider(
                create: (_) => HadithBloc(),
              ),
              BlocProvider(
                create: (_) => TafseerBloc(),
              ),
              BlocProvider(
                create: (_) => QuizBloc(),
              ),
              BlocProvider(
                create: (_) => NotificationBloc(),
              ),
              BlocProvider(
                create: (_) => OfflineModeBloc(),
              ),
              BlocProvider(
                create: (_) => ArticlesBloc(),
              ),
              BlocProvider(
                create: (_) => TasbeehBloc(),
              ),
              BlocProvider(
                create: (_) => SharingBloc(),
              ),
            ],
            child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, settingsState) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: languageProvider.locale,
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en'),
                    Locale('ar'),
                    Locale('ur'),
                    Locale('ru'),
                  ],
                  theme: ThemeData(
                    scaffoldBackgroundColor: backgroundColor,
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                    useMaterial3: true,
                    brightness: settingsState.settings.isDarkMode ? Brightness.dark : Brightness.light,
                    textTheme: TextTheme(
                      bodySmall: TextStyle(fontSize: settingsState.settings.fontSize - 2),
                      bodyMedium: TextStyle(fontSize: settingsState.settings.fontSize),
                      bodyLarge: TextStyle(fontSize: settingsState.settings.fontSize + 2),
                      labelSmall: TextStyle(fontSize: settingsState.settings.fontSize - 1),
                      labelMedium: TextStyle(fontSize: settingsState.settings.fontSize),
                      labelLarge: TextStyle(fontSize: settingsState.settings.fontSize + 1),
                      titleSmall: TextStyle(fontSize: settingsState.settings.fontSize + 2),
                      titleMedium: TextStyle(fontSize: settingsState.settings.fontSize + 4),
                      titleLarge: TextStyle(fontSize: settingsState.settings.fontSize + 6),
                      headlineSmall: TextStyle(fontSize: settingsState.settings.fontSize + 6),
                      headlineMedium: TextStyle(fontSize: settingsState.settings.fontSize + 8),
                      headlineLarge: TextStyle(fontSize: settingsState.settings.fontSize + 10),
                      displaySmall: TextStyle(fontSize: settingsState.settings.fontSize + 12),
                      displayMedium: TextStyle(fontSize: settingsState.settings.fontSize + 16),
                      displayLarge: TextStyle(fontSize: settingsState.settings.fontSize + 20),
                    ),
                  ),
                  home: const SplashScreen(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
