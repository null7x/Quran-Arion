import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_arion/bloc/album_bloc/album_bloc.dart';
import 'package:quran_arion/bloc/boarding_bloc/boarding_bloc.dart';
import 'package:quran_arion/bloc/home_bloc/home_bloc.dart';
import 'package:quran_arion/bloc/player_bloc/player_bloc.dart';
import 'package:quran_arion/bloc/quran_bloc/quran_bloc.dart';
import 'package:quran_arion/db_helper/db_helper.dart';
import 'package:quran_arion/res/app_colors.dart';
import 'package:quran_arion/view/splash/splash.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
