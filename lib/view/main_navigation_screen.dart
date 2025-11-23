import 'package:flutter/material.dart';
import 'package:quran_arion/res/app_colors.dart';
import 'package:quran_arion/view/home/home_view.dart';
import 'package:quran_arion/view/quran_books/quran_books_view.dart';
import 'package:quran_arion/view/qibla_compass/qibla_compass_view.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const QuranBooksView(),
    const QiblaCompassView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: shadowColor,
        selectedItemColor: blueShade,
        unselectedItemColor: lightShadowColor.withOpacity(0.5),
        elevation: 10,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Recitations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Quran Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Qibla Compass',
          ),
        ],
      ),
    );
  }
}
