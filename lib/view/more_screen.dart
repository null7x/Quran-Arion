import 'package:flutter/material.dart';
import 'package:quran_arion/res/app_colors.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        backgroundColor: backgroundColor,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: primaryColor,
          labelColor: primaryColor,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Library'),
            Tab(text: 'Tools'),
            Tab(text: 'Content'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLibraryTab(),
          _buildToolsTab(),
          _buildContentTab(),
        ],
      ),
    );
  }

  Widget _buildLibraryTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildMenuCard(
          icon: Icons.favorite,
          title: 'Favorites',
          subtitle: 'Your liked songs',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.bookmark,
          title: 'Bookmarks',
          subtitle: 'Saved verses and chapters',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.history,
          title: 'History',
          subtitle: 'Recently played',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.download,
          title: 'Downloads',
          subtitle: 'Offline content',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildToolsTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildMenuCard(
          icon: Icons.bar_chart,
          title: 'Statistics',
          subtitle: 'Your reading stats',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.calendar_month,
          title: 'Islamic Calendar',
          subtitle: 'Hijri calendar',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.schedule,
          title: 'Prayer Times',
          subtitle: 'Daily prayer schedule',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.compass_calibration,
          title: 'Qibla Direction',
          subtitle: 'Direction to Mecca',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.self_improvement,
          title: 'Tasbeeh Counter',
          subtitle: 'Dhikr counter',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildContentTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildMenuCard(
          icon: Icons.article,
          title: 'Articles',
          subtitle: 'Islamic articles',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.menu_book,
          title: 'Hadith',
          subtitle: 'Prophet sayings',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.lightbulb,
          title: 'Tafseer',
          subtitle: 'Quran explanation',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.quiz,
          title: 'Quiz',
          subtitle: 'Islamic quizzes',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.pray_times,
          title: 'Duas',
          subtitle: 'Islamic prayers',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSettingsTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildMenuCard(
          icon: Icons.settings,
          title: 'App Settings',
          subtitle: 'General settings',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.notifications,
          title: 'Notifications',
          subtitle: 'Notification preferences',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.language,
          title: 'Language',
          subtitle: 'Change app language',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.help,
          title: 'Help & FAQ',
          subtitle: 'Get help',
          onTap: () {},
        ),
        _buildMenuCard(
          icon: Icons.info,
          title: 'About',
          subtitle: 'App information',
          onTap: () {},
        ),
      ],
    );
  }
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: primaryColor, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: primaryColor, size: 16),
          ],
        ),
      ),
    );
  }
}
