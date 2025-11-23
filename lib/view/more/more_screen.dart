import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_arion/res/app_colors.dart';
import 'package:quran_arion/utils/translations.dart';
import 'package:quran_arion/providers/app_language_provider.dart';
import 'package:quran_arion/view/favorites/favorites_view.dart';
import 'package:quran_arion/view/bookmarks/bookmarks_view.dart';
import 'package:quran_arion/view/statistics/statistics_view.dart';
import 'package:quran_arion/view/islamic_calendar/islamic_calendar_view.dart';
import 'package:quran_arion/view/prayer_times/prayer_times_view.dart';
import 'package:quran_arion/view/qibla_compass/qibla_compass_view.dart';
import 'package:quran_arion/view/history/history_view.dart';
import 'package:quran_arion/view/articles/articles_view.dart';
import 'package:quran_arion/view/notifications/notifications_view.dart';
import 'package:quran_arion/view/settings/settings_view.dart';
import 'package:quran_arion/view/daily_verse/daily_verse_view.dart';
import 'package:quran_arion/view/hadith/hadith_view.dart';
import 'package:quran_arion/view/tafseer/tafseer_view.dart';
import 'package:quran_arion/view/duas/duas_view.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.get('more')),
        backgroundColor: AppColors.shadowColor,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.blueShade,
          labelColor: AppColors.blueShade,
          unselectedLabelColor: AppColors.lightShadowColor,
          tabs: [
            Tab(text: Translations.get('library')),
            Tab(text: Translations.get('tools')),
            Tab(text: Translations.get('content')),
            Tab(text: Translations.get('settings')),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // LIBRARY TAB
          ListView(
            children: [
              _buildMenuTile(
                icon: Icons.favorite,
                title: Translations.get('favorites'),
                subtitle: Translations.get('yourLikedSongs'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoritesView()),
                ),
              ),
              _buildMenuTile(
                icon: Icons.bookmark,
                title: Translations.get('bookmarks'),
                subtitle: Translations.get('savedVerses'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BookmarksView()),
                ),
              ),
              _buildMenuTile(
                icon: Icons.history,
                title: Translations.get('history'),
                subtitle: Translations.get('recentlyPlayed'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('History view coming soon')),
                  );
                },
              ),
            ],
          ),
          
          // TOOLS TAB
          ListView(
            children: [
              _buildMenuTile(
                icon: Icons.history,
                title: 'Playback History',
                subtitle: 'Your listening history',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryView()),
                ),
              ),
              _buildMenuTile(
                icon: Icons.bar_chart,
                title: Translations.get('statistics'),
                subtitle: 'Your listening stats',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StatisticsView()),
                ),
              ),
              _buildMenuTile(
                icon: Icons.calendar_month,
                title: Translations.get('calendar'),
                subtitle: 'Islamic calendar',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const IslamicCalendarView()),
                ),
              ),
              _buildMenuTile(
                icon: Icons.access_time,
                title: Translations.get('prayerTimes'),
                subtitle: 'Prayer schedules',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrayerTimesView()),
                ),
              ),
              _buildMenuTile(
                icon: Icons.compass_calibration,
                title: Translations.get('qiblaDirection'),
                subtitle: 'Find Qibla',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QiblaCompassView()),
                ),
              ),
            ],
          ),
          
          // CONTENT TAB
          ListView(
            children: [
              _buildMenuTile(
                icon: Icons.article,
                title: Translations.get('articles'),
                subtitle: 'Islamic articles',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ArticlesView()),
                ),
              ),
              _buildMenuTile(
                icon: Icons.menu_book,
                title: Translations.get('dailyVerse'),
                subtitle: 'Daily verse',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DailyVerseView()),
                ),
              ),
              _buildMenuTile(
                icon: Icons.book,
                title: Translations.get('hadith'),
                subtitle: 'Hadith collection',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HadithView()),
                ),
              ),
              _buildMenuTile(
                icon: Icons.notes,
                title: Translations.get('tafseer'),
                subtitle: 'Quran explanation',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TafseerView()),
                ),
              ),
              _buildMenuTile(
                icon: Icons.favorite_border,
                title: 'Duas',
                subtitle: 'Islamic prayers',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DuasView()),
                ),
              ),
            ],
          ),

          // SETTINGS TAB
          ListView(
            children: [
              _buildMenuTile(
                icon: Icons.notifications,
                title: Translations.get('notifications'),
                subtitle: 'Manage alerts',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationsView()),
                ),
              ),
              _buildMenuTile(
                icon: Icons.settings,
                title: Translations.get('settings'),
                subtitle: 'App preferences',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsView()),
                ),
              ),
              _buildMenuTile(
                icon: Icons.help_outline,
                title: 'Help & FAQ',
                subtitle: 'Get help',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Contact Support'),
                      content: const Text('For help and support, please contact us at:\ns985225250@gmail.com'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              _buildMenuTile(
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'App information',
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Quran-Arion',
                    applicationVersion: '1.0.0',
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Developed by Azizov Aminjon'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.blueShade,
        size: 28,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: AppColors.lightShadowColor.withOpacity(0.7),
          fontSize: 13,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColors.lightShadowColor.withOpacity(0.5),
        size: 16,
      ),
      onTap: onTap,
    );
  }
}
