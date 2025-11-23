import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_arion/res/app_colors.dart';
import 'package:quran_arion/utils/translations.dart';
import 'package:quran_arion/providers/app_language_provider.dart';
import 'package:quran_arion/view/home/home_view.dart';
import 'package:quran_arion/view/search/search_view.dart';
import 'package:quran_arion/view/quran_books/quran_books_view.dart';
import 'package:quran_arion/view/user_profile/user_profile_view.dart';
import 'package:quran_arion/view/more/more_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // Only 4 main screens
  final List<Widget> _screens = [
    const HomeView(),           // 0 - Home
    const SearchView(),         // 1 - Search
    const QuranBooksView(),     // 2 - Library
    const UserProfileView(),    // 3 - Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLanguageProvider>(
      builder: (context, langProvider, child) {
        return Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColors.shadowColor,
              border: Border(
                top: BorderSide(
                  color: AppColors.lightShadowColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onTabTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: AppColors.blueShade,
              unselectedItemColor: AppColors.lightShadowColor.withOpacity(0.5),
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Icon(
                      _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                      size: 28,
                    ),
                  ),
                  label: Translations.get('home'),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Icon(
                      _selectedIndex == 1 ? Icons.search : Icons.search_outlined,
                      size: 28,
                    ),
                  ),
                  label: Translations.get('search'),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Icon(
                      _selectedIndex == 2 ? Icons.library_books : Icons.library_books_outlined,
                      size: 28,
                    ),
                  ),
                  label: Translations.get('library'),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Icon(
                      _selectedIndex == 3 ? Icons.person : Icons.person_outline,
                      size: 28,
                    ),
                  ),
                  label: Translations.get('profile'),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Icon(
                      Icons.more_horiz,
                      size: 28,
                    ),
                  ),
                  label: Translations.get('more'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onTabTapped(int index) {
    if (index == 4) {
      // More menu - navigate to MoreScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MoreScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}
