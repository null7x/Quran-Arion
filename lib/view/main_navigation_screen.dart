import 'package:flutter/material.dart';
import 'package:quran_arion/res/app_colors.dart';
import 'package:quran_arion/view/home/home_view.dart';
import 'package:quran_arion/view/quran_books/quran_books_view.dart';
import 'package:quran_arion/view/qibla_compass/qibla_compass_view.dart';
import 'package:quran_arion/view/qari_playlists/qari_playlists_view.dart';
import 'package:quran_arion/view/prayer_times/prayer_times_view.dart';
import 'package:quran_arion/view/favorites/favorites_view.dart';
import 'package:quran_arion/view/daily_verse/daily_verse_view.dart';
import 'package:quran_arion/view/search/search_view.dart';
import 'package:quran_arion/view/islamic_calendar/islamic_calendar_view.dart';
import 'package:quran_arion/view/duas/duas_view.dart';
import 'package:quran_arion/view/user_profile/user_profile_view.dart';
import 'package:quran_arion/view/settings/settings_view.dart';
import 'package:quran_arion/view/bookmarks/bookmarks_view.dart';
import 'package:quran_arion/view/statistics/statistics_view.dart';
import 'package:quran_arion/view/hadith/hadith_view.dart';
import 'package:quran_arion/view/tafseer/tafseer_view.dart';
import 'package:quran_arion/view/quiz/quiz_view.dart';
import 'package:quran_arion/view/notifications/notifications_view.dart';
import 'package:quran_arion/view/offline/offline_view.dart';
import 'package:quran_arion/view/articles/articles_view.dart';
import 'package:quran_arion/view/tasbeeh/tasbeeh_view.dart';
import 'package:quran_arion/view/sharing/sharing_view.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const QariPlaylistsView(),
    const QuranBooksView(),
    const QiblaCompassView(),
    const PrayerTimesView(),
    const FavoritesView(),
    const DailyVerseView(),
    const SearchView(),
    const IslamicCalendarView(),
    const DuasView(),
    const UserProfileView(),
    const BookmarksView(),
    const StatisticsView(),
    const SettingsView(),
    const HadithView(),
    const TafseerView(),
    const QuizView(),
    const NotificationsView(),
    const OfflineView(),
    const ArticlesView(),
    const TasbeehView(),
    const SharingView(),
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
        type: BottomNavigationBarType.fixed,
        backgroundColor: shadowColor,
        selectedItemColor: blueShade,
        unselectedItemColor: lightShadowColor.withOpacity(0.5),
        elevation: 10,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Recitations',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Reciters',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Quran',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Qibla',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Prayers',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Verse',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hands_free_prayer),
            label: 'Duas',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Hadith',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Tafseer',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notify',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_download),
            label: 'Offline',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Articles',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.beenhere),
            label: 'Tasbeeh',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Share',
            backgroundColor: AppColors.backgroundColor,
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
            backgroundColor: AppColors.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: AppColors.backgroundColor,
          ),
        ],
      ),
    );
  }
}
