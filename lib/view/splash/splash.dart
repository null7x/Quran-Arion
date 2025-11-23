import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/album_bloc/album_bloc.dart';
import 'package:quran_arion/bloc/album_bloc/album_event.dart';
import 'package:quran_arion/res/app_colors.dart';
import 'package:quran_arion/res/app_icons.dart';
import 'package:quran_arion/view/common_widget/soft_button.dart';

import '../../view_model/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashServices.isFirstTime(context: context);
    // context.read<HomeBloc>().add(GetFilesEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularSoftButton(
              radius: 45,
              padding: 10,
              icon: Container(
                margin: const EdgeInsets.all(5),
                child: Center(
                  child: Icon(Icons.menu_book_rounded, color: blueShade, size: 60,),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Quran-Arion', style: TextStyle(
              color: blueShade,
              fontWeight: FontWeight.bold,
              fontSize: 30
            ),),
            SizedBox(height: 10),
            Text('Islamic Quran Recitation App', style: TextStyle(
              color: lightShadowColor,
              fontSize: 14
            ),)
          ],
        ),
      ),
    );
  }
}
